---
title: Hibernate-Validation注解
date: 2020-06-28 14:44:42
collection: 校验器
---

## 作用

使用hibernate-validation进行校验参数入参的切面

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