Return-Path: <linux-sparse-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1FB2C64EC4
	for <linux-sparse@archiver.kernel.org>; Mon,  6 Mar 2023 22:29:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbjCFW3Z (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 6 Mar 2023 17:29:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjCFW3Y (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 6 Mar 2023 17:29:24 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB2414A1EC
        for <linux-sparse@vger.kernel.org>; Mon,  6 Mar 2023 14:29:22 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id i3so12145255plg.6
        for <linux-sparse@vger.kernel.org>; Mon, 06 Mar 2023 14:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112; t=1678141762;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D6v/dxyavLz1aFpAiSmt8lqXZjxsbR0XXvhbxHk4HCc=;
        b=raUgWIxnnAFrbHyipMfm3neMx6EWucvpImMWcmV6s64JMe8na96VFed7BXiX16NG6D
         ELZSrBmRk6D53KDKSJJOgxAyhch6WHnD7akn2pdrEfbd41Ep0QrKG/R79e3xckvxfVgt
         25JpBzIqGntlVh1GYdpxF/fpheF0vW0qq8YrhZFXFWcgBYjIxCzeesIsesc7M2VpfdNb
         8F99/uSC8gCdaH7VzyYvBO/rmZV27MR3yph9u+GKC3RJ9UKg9tqSoTE0LSjllAShZy8w
         ovJSUT8/GZZiWgGimp8gSyfzXBMSO1S/jWCyx1xn7rA6fmvMqhllhx0ZIfg/MM3MXRa+
         1Mgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678141762;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D6v/dxyavLz1aFpAiSmt8lqXZjxsbR0XXvhbxHk4HCc=;
        b=zmGAgl93SRJIwuXr8RBlea85PuPwuI6ltymzcofd0gnLYkFZCNJaak+mdgqEM77AiD
         B7NNAXRKhJG4t4ypUt6yysJawlWpgyFt+npPmDI5KQOSQVgmeKR394V/8WSQU6fcUuqH
         4uoc1HvJvhL+ZNu7o3nXWeRwcQJk7kXd8ebAP1sS+gpMejhVALJB3Wf33CDLl8vWUcYP
         Qhn3KpUGGg38THYclAfqEGkynV5fieK9l9WIt15DT/P2Y33TeUuZQl4aKTrNd/mVdLHx
         tTs/f81J5nlzjyKYGmPwDB526PBXEiSKtb7N8Nqn+TEYKezbrjbPnWCfKTR9dgLGIKwp
         DWfg==
X-Gm-Message-State: AO0yUKXX4ybrzubYynrK9uh9nE3F3eOGw70OazkaaskdUWBlJnsYRkf1
        s9Qe/pyJUI9GfY+ku2pqzvFsKS8R/D/9mcW70sY=
X-Google-Smtp-Source: AK7set+ih/AJFfbVvSaYJDPFgE0Em+vhUav6ZHgNMNlbRO6lFb3JcQdzWha4SnZVstxiA4+5WOLXIA==
X-Received: by 2002:a17:903:247:b0:19e:6ffd:a310 with SMTP id j7-20020a170903024700b0019e6ffda310mr15872531plh.48.1678141761902;
        Mon, 06 Mar 2023 14:29:21 -0800 (PST)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id s12-20020a17090302cc00b001992e74d058sm7251876plk.7.2023.03.06.14.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 14:29:21 -0800 (PST)
Date:   Mon, 06 Mar 2023 14:29:21 -0800 (PST)
X-Google-Original-Date: Mon, 06 Mar 2023 14:28:33 PST (-0800)
Subject:     Re: [PATCH v1] RISC-V: Add basic support for the vector extension
In-Reply-To: <20230306222321.1992900-1-conor@kernel.org>
CC:     linux-sparse@vger.kernel.org, Conor Dooley <conor@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        luc.vanoostenryck@gmail.com, linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Conor Dooley <conor@kernel.org>
Message-ID: <mhng-ac1d596b-0748-4dab-8161-80c8d5537db2@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Mon, 06 Mar 2023 14:23:22 PST (-0800), Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
>
> I've started hitting this in CI while testing Andy's vector enablement
> series. I'm not entirely sure if there is more to do here, other than
> squeezing in the duplicate of what has been done for other extensions.
>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> This is based on top of patches already on the sparse list, adding
> support for some multi-letter extensions for RISC-V:
> https://lore.kernel.org/linux-sparse/20220811033138.20676-1-palmer@rivosinc.com/
> https://lore.kernel.org/linux-sparse/20220811052957.16634-1-palmer@rivosinc.com/
>
> CC: luc.vanoostenryck@gmail.com
> CC: palmer@dabbelt.com
> CC: linux-sparse@vger.kernel.org
> CC: linux-riscv@lists.infradead.org
> ---
>  target-riscv.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/target-riscv.c b/target-riscv.c
> index 8338d7a6..c8282814 100644
> --- a/target-riscv.c
> +++ b/target-riscv.c
> @@ -21,6 +21,7 @@
>  #define RISCV_ZIFENCEI		(1 << 11)
>  #define RISCV_ZICBOM		(1 << 12)
>  #define RISCV_ZIHINTPAUSE	(1 << 13)
> +#define RISCV_VECTOR		(1 << 14)
>
>  static unsigned int riscv_flags;
>
> @@ -41,6 +42,7 @@ static void parse_march_riscv(const char *arg)
>  		{ "f",			RISCV_FLOAT|RISCV_FDIV|RISCV_ZICSR },
>  		{ "d",			RISCV_DOUBLE|RISCV_FDIV|RISCV_ZICSR },
>  		{ "c",			RISCV_COMP },
> +		{ "v",			RISCV_VECTOR },
>  		{ "_zicsr",		RISCV_ZICSR },
>  		{ "_zifencei",		RISCV_ZIFENCEI },
>  		{ "_zicbom",		RISCV_ZICBOM },
> @@ -147,6 +149,8 @@ static void predefine_riscv(const struct target *self)
>  		predefine("__riscv_zicbom", 1, "1");
>  	if (riscv_flags & RISCV_ZIHINTPAUSE)
>  		predefine("__riscv_zihintpause", 1, "1");
> +	if (riscv_flags & RISCV_VECTOR)
> +		predefine("__riscv_vector", 1, "1");

V adds a bunch of V-subset extensions.  I don't think we need to 
faithfully handle those, but we should at least set the right element 
type and length fields for V as code might depend on those.

>
>  	if (cmodel)
>  		predefine_strong("__riscv_cmodel_%s", cmodel);
