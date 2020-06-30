---
title: hibernate-validator
date: 2020-06-28 14:44:42
collection: 校验器
---

## 作用

使用hibernate-validation进行校验参数入参的切面

## 使用

如果是复杂的bean对象，需要加@Valid注解，如

```java
public class A {
    private String a;

    /**
    *  这里加了Valid注解后才能生效
    **/
    @Valid
    private B b;
}

public class B {
    @NotNull
    private String b;
}
```

```txt
AssertFalse

被注释的元素必须为boolean,且为false

AssertTrue

被注释的元素必须为boolean,且为true

DecimalMax

被注释的元素必须为数字,且小于等于最大值

DecimalMin

被注释的元素必须为数字,且大于等于最小值

Digits

被注释的元素必须为数字,且精度在指定的整数和小数范围内

Future

被注释的元素必须为日期且大于当前时间(是未来的时间)

Max

被注释的元素必须是数字,且小于等于最大值

Min

被注释的元素必须是数字,且大于等于最小值

NotNull

被注释的元素必须不为 null

Null

被注释的元素必须为 null

Past

被注释的元素必须为日期且小于当前时间(是过去的时间)

Pattern

被注释的元素必须字符串,且符合指定正则表达式,如果为null则不校验

Size

被注释的元素必须是字符串,长度大于等于min值,小于等于max值

Annotation Type

Description   (import org.hibernate.validator.constraints.*)

Email

被注释的元素必须是电子邮箱地址 

NotBlank

被注释的字符串必须非空 

NotEmpty

被注释的字符串或列表的必须非空 

Range

被注释的元素必须在合适的范围内

URL

被注释的字符串的必须符合url地址格式
```

## 快速使用

### 依赖

```xml
<dependency>
    <groupId>org.hibernate</groupId>
    <artifactId>hibernate-validator</artifactId>
    <version>5.3.6.Final</version>
</dependency>
```

### 注解

```java
@Retention(RetentionPolicy.RUNTIME)
public @interface ParamValidate {
}
```

### 切面

```java
@Component
@Aspect
@Slf4j
public class ParamValidationAspect {

    @Pointcut(value = "@annotation(paramValidate)", argNames = "paramValidate")
    public void logPointcut(ParamValidate paramValidate) {
        // 横切点
    }

    @Around(value = "logPointcut(paramValidate)")
    public Object around(ProceedingJoinPoint joinPoint, ParamValidate paramValidate) throws Throwable {
        MethodSignature methodSignature = (MethodSignature) joinPoint.getSignature();
        methodSignature.getParameterTypes();

        for (Object param : joinPoint.getArgs()) {
            ValidationUtil.ValidResult validResult = ValidationUtil.validateBean(param);
            if (validResult.isHasErrors()) {
                // TODO 自定义失败的返回
            }
        }

        return joinPoint.proceed();
    }
}

```

### 校验工具类

这个类是直接抄网上的

```java
public class ValidationUtil {
    /**
     * 开启快速结束模式 failFast (true)
     */
    private static Validator validator = Validation.byProvider(HibernateValidator.class).configure().failFast(false).buildValidatorFactory().getValidator();

    /**
     * 校验对象
     *
     * @param t bean
     * @param groups 校验组
     * @return ValidResult
     */
    public static <T> ValidResult validateBean(T t,Class<?>...groups) {
        ValidResult result = new ValidationUtil().new ValidResult();
        Set<ConstraintViolation<T>> violationSet = validator.validate(t,groups);
        boolean hasError = violationSet != null && violationSet.size() > 0;
        result.setHasErrors(hasError);
        if (hasError) {
            for (ConstraintViolation<T> violation : violationSet) {
                result.addError(violation.getPropertyPath().toString(), violation.getMessage());
            }
        }
        return result;
    }

    /**
     * 校验bean的某一个属性
     *
     * @param obj          bean
     * @param propertyName 属性名称
     * @return ValidResult
     */
    public static <T> ValidResult validateProperty(T obj, String propertyName) {
        ValidResult result = new ValidationUtil().new ValidResult();
        Set<ConstraintViolation<T>> violationSet = validator.validateProperty(obj, propertyName);
        boolean hasError = violationSet != null && violationSet.size() > 0;
        result.setHasErrors(hasError);
        if (hasError) {
            for (ConstraintViolation<T> violation : violationSet) {
                result.addError(propertyName, violation.getMessage());
            }
        }
        return result;
    }

    /**
     * 校验结果类
     */
    @Data
    public class ValidResult {

        /**
         * 是否有错误
         */
        private boolean hasErrors;

        /**
         * 错误信息
         */
        private List<ErrorMessage> errors;

        public ValidResult() {
            this.errors = new ArrayList<>();
        }
        public boolean hasErrors() {
            return hasErrors;
        }

        public void setHasErrors(boolean hasErrors) {
            this.hasErrors = hasErrors;
        }

        /**
         * 获取所有验证信息
         * @return 集合形式
         */
        public List<ErrorMessage> getAllErrors() {
            return errors;
        }

        /**
         * 获取所有验证信息
         * @return 字符串形式
         */
        public String getErrors(){
            StringBuilder sb = new StringBuilder();
            for (ErrorMessage error : errors) {
                sb.append(error.getPropertyPath()).append(":").append(error.getMessage()).append(" ");
            }
            return sb.toString();
        }

        public void addError(String propertyName, String message) {
            this.errors.add(new ErrorMessage(propertyName, message));
        }
    }

    @Data
    @NoArgsConstructor
    @AllArgsConstructor
    public class ErrorMessage {

        private String propertyPath;

        private String message;
    }
}
```