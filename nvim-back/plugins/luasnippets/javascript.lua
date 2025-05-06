return {
    s("cn", {
        t("className={styles['"),
        i(1, "class-name"),
        t("']}"),
    }),
    s("cx", {
        t("className={cx(styles['"),
        i(1, "class-name"),
        t("'])}"),
    }),
    s("cxc", {
        t({"className={cx(", "styles['"}),
        i(1, "class-name"),
        t({"']"}),
        d(2, function(args)
            return sn(nil,
                {
                    t({",", "{[styles['"}),
                    t(args[1]),
                    t("--"),
                    i(1, "modifier"),
                    t("'] as string]:"),
                    i(2, "boolean"),
                    t({"}", ")}"}),
                }
            )
            end , {1}),
    }),
}
