Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A45C433EF
	for <linux-sparse@archiver.kernel.org>; Sat, 21 May 2022 21:52:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346786AbiEUVwh (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 21 May 2022 17:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237130AbiEUVwf (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 21 May 2022 17:52:35 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D065A3EA84
        for <linux-sparse@vger.kernel.org>; Sat, 21 May 2022 14:52:33 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id gh17so8631160ejc.6
        for <linux-sparse@vger.kernel.org>; Sat, 21 May 2022 14:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lhqDaPng1+rkR278Y3VlEC/fO44ND23dAfQ1G8YCCB8=;
        b=GQjSOd/UKrCh8XOCWTN7wvpZqdXZiDxxpauAeARK/YG5PG2AgEyaZ9bjPQM8BKAnKU
         Lj4nbiaorgFuIqXxKuzN+1X0O9rN8WA9ZASGOEBKdTL9yVj67uv1RRtna8a/PZ7CB+H7
         7cIAk4zF9F6+Q7gVva8aLQZQvC2AUyVnpQ8Kme85ejVZZWrd/hrBLxtyO163t5HvnK5q
         XA12qAMzmJLiJguF4aJuYm0GNfmw/0/0hOszL+kdF8+tKQ7Vm15VzW9SWpbeb5Yo5U2a
         cAHQ2kpkc0kgtHQkDl+whD7mNEdv9OhLmgxBQ4x65an5V/MTV1FR+EMsG2o1xmQBjt54
         hpsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lhqDaPng1+rkR278Y3VlEC/fO44ND23dAfQ1G8YCCB8=;
        b=FylCRm8hytPP2iS/p9zyIesmTxg0WUDiQLH5NxAC9op4p7ss3hQ/QFgKbrbbdD1g1t
         CCOPOzQ/3mBXighftfsvxvZ/35hCYKzah1KjOCvjBlKUcKLjhBEx+qevDQEkKxxJZigH
         gFvgH35n6AQoq90HzKqx3rykwX8KyO5vKuT3RXelWQCmGs4DfmNZq0xRJs8xfbHFgV+q
         wZwKlEMXYSyfmH/o2qgET1pBlhKoj1d9auOtiqCsFKsZ8PxlXpo7owx+CI1MFJ+8KHLx
         NcHz1T1SyT4D/PTPf2XmpvbeKOckHywYu1FGr65mwgIy2gpsfBvpZFDSlUk2pu30L96f
         m7KA==
X-Gm-Message-State: AOAM532N620j9seWwLVWUuWxqZi5IEIxp5LcSt66WKWJvCgbBoqI2AZp
        pXmv9gVYOjcmCtIawBpd8og=
X-Google-Smtp-Source: ABdhPJx/bbB1i2GUTWTqk9nbhSd4CD/YIrK/kooZdYTLqaRet9U4rNhV4ffWCgfJ0KJZT0fNhq+pRw==
X-Received: by 2002:a17:907:9487:b0:6f8:747a:845e with SMTP id dm7-20020a170907948700b006f8747a845emr14307658ejc.299.1653169952432;
        Sat, 21 May 2022 14:52:32 -0700 (PDT)
Received: from mail (239.125-180-91.adsl-dyn.isp.belgacom.be. [91.180.125.239])
        by smtp.gmail.com with ESMTPSA id qs24-20020a170906459800b006f3ef214daesm4606931ejc.20.2022.05.21.14.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 14:52:31 -0700 (PDT)
Date:   Sat, 21 May 2022 23:52:31 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     linux-sparse@vger.kernel.org, Kito Cheng <kito.cheng@gmail.com>,
        linux-riscv@lists.infradead.org, mkl@pengutronix.de,
        aurelien@aurel32.net,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v1 2/6] RISC-V: Match GCC's semantics for multiple -march
 instances
Message-ID: <20220521215231.66yvpgji64uqbyzv@mail>
References: <20220402050041.21302-1-palmer@rivosinc.com>
 <20220402050041.21302-3-palmer@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220402050041.21302-3-palmer@rivosinc.com>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Fri, Apr 01, 2022 at 10:00:37PM -0700, Palmer Dabbelt wrote:
> GCC's semantics for "-march=X -march=Y" are that Y entirely overrides X,
> but sparse takes the union of these two ISA strings.

OK, but then I prefer to explicitly clear riscv_flags at the start
of the function, like:

diff --git a/target-riscv.c b/target-riscv.c
index 3bba7c15ff1f..ca38d76e6465 100644
--- a/target-riscv.c
+++ b/target-riscv.c
@@ -54,6 +54,9 @@ static void parse_march_riscv(const char *arg)
 	};
 	int i;
 
+	// Each -march=.. options entirely overrides previous ones
+	riscv_flags = 0;
+
 	for (i = 0; i < ARRAY_SIZE(basic_sets); i++) {
 		const char *pat = basic_sets[i].pattern;
 		size_t len = strlen(pat);


-- Luc
