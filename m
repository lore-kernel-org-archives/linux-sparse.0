Return-Path: <SRS0=w175=AY=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C20D2C433DF
	for <linux-sparse@archiver.kernel.org>; Mon, 13 Jul 2020 22:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E3F820B80
	for <linux-sparse@archiver.kernel.org>; Mon, 13 Jul 2020 22:33:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SEBkbUcs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbgGMWdR (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 13 Jul 2020 18:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbgGMWdO (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 13 Jul 2020 18:33:14 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6039FC061794
        for <linux-sparse@vger.kernel.org>; Mon, 13 Jul 2020 15:33:14 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id l12so19261656ejn.10
        for <linux-sparse@vger.kernel.org>; Mon, 13 Jul 2020 15:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OJxKW6Q+ZX0US0dhycJWTO0SaPn/we8YRmxl2e76kxc=;
        b=SEBkbUcs5eyTnSCiDqx9Sq53vGCkQJXTc2fdwn8E84dXgxw7etJD7Xjl7E30FFsiDa
         uEISVhpkh4Cd2fNqplo8bQ75C/Ow1WJGyELQn3LpKPWglXD6mCJHQ4eJy3waBIWtOt5w
         2q+1PiLBbx9NJHpfh0Mjnso2KYTe0k9Bqk/HnsAsP3GRiBU9QhBc3T831EqJcWvooqof
         u/Xw+mVfrz7Tw+CwyLdC1xOszGP+jTRDPfN+9mltsZis8wn49ypb0+6ViEWZZjxVIjY8
         EE+xD51M2fg1pkEgpepUMs0qeAs35+nC5WAHezvR7WhU+jzZKEBM/BbAjLZLYrt8mbbh
         Z0yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OJxKW6Q+ZX0US0dhycJWTO0SaPn/we8YRmxl2e76kxc=;
        b=fKny6J9xY0tTtaEztRJ5FUcQoTi6iElt6s9hCbLefIL4T46hJ47mrZrJIauWGhTwks
         7Y6i+VX7f3jrhDUJ8ofvX4XPQKubO9QGp1CBwcJEeOOtnwzBQis9YMS2knfR/9d5hw+P
         AmSYRHO6AYniyogn0OnqMA5mdVxLP4tithuE+gGzWVYz1jirbYcM6yyb9AN03AusGiFf
         /IK8N4fqJs8joRM6Y5pK/jljvri5AfgRIK6XATt5fje1Xr1TPvR0nDK2nDKIvgsGJgH8
         Qcpt5npipWs34enapLXYKx0miFLFue14LzYkl0x7zga5lzPnG1v31EPH12r7KEI79ZDe
         7AKg==
X-Gm-Message-State: AOAM530DMISSvHBoJlUXPnVX5bn7UvVYicP99IZV1k/yjiq/ci1ktheO
        aYdyf2YtzBzfvbjLjUfOayK3TsXT
X-Google-Smtp-Source: ABdhPJzLaWKxDzqQl6f62IDvZBM4TiOerdFwkE2V/7Aoux9vfYOobuzcqw3CC5qMxINRvDJ19ZFglg==
X-Received: by 2002:a17:906:1747:: with SMTP id d7mr1803713eje.39.1594679592910;
        Mon, 13 Jul 2020 15:33:12 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7f9:7600:64:f40c:5c10:8e2d])
        by smtp.gmail.com with ESMTPSA id y7sm10792431ejd.73.2020.07.13.15.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 15:33:12 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 6/9] predefine: teach sparse about __SIG_ATOMIC_TYPE__
Date:   Tue, 14 Jul 2020 00:33:00 +0200
Message-Id: <20200713223304.83666-7-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200713223304.83666-1-luc.vanoostenryck@gmail.com>
References: <20200713223304.83666-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

This type is predefined by GCC so add it to sparse too.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 predefine.c | 1 +
 target.c    | 1 +
 target.h    | 1 +
 3 files changed, 3 insertions(+)

diff --git a/predefine.c b/predefine.c
index 2e9913d5c0bc..60ecc7070045 100644
--- a/predefine.c
+++ b/predefine.c
@@ -170,6 +170,7 @@ void predefined_macros(void)
 	predefined_ctype("PTRDIFF",  ssize_t_ctype, PTYPE_ALL_T|PTYPE_TYPE);
 	predefined_ctype("SIZE",      size_t_ctype, PTYPE_ALL_T|PTYPE_TYPE);
 	predefined_ctype("POINTER",     &ptr_ctype, PTYPE_SIZEOF);
+	predefined_ctype("SIG_ATOMIC", sig_atomic_ctype, PTYPE_MAX|PTYPE_MIN|PTYPE_TYPE|PTYPE_WIDTH);
 
 	predefined_sizeof("FLOAT", "", bits_in_float);
 	predefined_sizeof("DOUBLE", "", bits_in_double);
diff --git a/target.c b/target.c
index 655a1527f93f..f320ab525dfb 100644
--- a/target.c
+++ b/target.c
@@ -31,6 +31,7 @@ struct symbol *fast32_ctype = &long_ctype;
 struct symbol *ufast32_ctype = &ulong_ctype;
 struct symbol *fast64_ctype = &long_ctype;
 struct symbol *ufast64_ctype = &ulong_ctype;
+struct symbol *sig_atomic_ctype = &int_ctype;
 
 /*
  * For "__attribute__((aligned))"
diff --git a/target.h b/target.h
index 3fdfc1e69339..5bbce397bba5 100644
--- a/target.h
+++ b/target.h
@@ -29,6 +29,7 @@ extern struct symbol *fast32_ctype;
 extern struct symbol *ufast32_ctype;
 extern struct symbol *fast64_ctype;
 extern struct symbol *ufast64_ctype;
+extern struct symbol *sig_atomic_ctype;
 
 /*
  * For "__attribute__((aligned))"
-- 
2.27.0

