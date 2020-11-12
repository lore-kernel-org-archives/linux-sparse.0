Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 765FAC388F9
	for <linux-sparse@archiver.kernel.org>; Thu, 12 Nov 2020 01:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EC48206F1
	for <linux-sparse@archiver.kernel.org>; Thu, 12 Nov 2020 01:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IOC5cWJM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbgKLBds (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 11 Nov 2020 20:33:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728014AbgKLAGf (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 11 Nov 2020 19:06:35 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03406C0613D4
        for <linux-sparse@vger.kernel.org>; Wed, 11 Nov 2020 16:06:35 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id t11so4166861edj.13
        for <linux-sparse@vger.kernel.org>; Wed, 11 Nov 2020 16:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wNL2F6WNZupMmsi0P8Xket99a3mRr+2KFtcrLO6xNW8=;
        b=IOC5cWJMEvzkoPKN1sUgiYuaO7de4JFa25MhWKZFMOQ60zm8LS9ec7QqEablSxYFN6
         JwoYgXXXiIlJLz6ye1i3BSqRKbrtj+u83tVtXFWCaRAEwcbSVzSpjVVpFI2cJsl50MMs
         TAe1OmpuwzYOSZhHfdWXHQZlUrdm2UQr+K2SfZqlOWJe5b9jKDq+6SSl0MbFKvUi3ITh
         mC5KiNted+WemFNMxINgvt6do2EbsCFaNkatKtY1PZ7Wcos21xQgFbsnBOBC6Kog0YsU
         CUGg0+nl2aSAHEDupKamalsnOmt2oiCD44ICwZ+45hjYgx05sJbrGjHYbLvRJXV7MLs0
         OBOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wNL2F6WNZupMmsi0P8Xket99a3mRr+2KFtcrLO6xNW8=;
        b=KURLGoXU+iF93w0VPXBQe157z38p5xbxlKe8JN/v6C+3bcS7/Y5h74f0OLnBwLq7m4
         k3HdqvKkCMBgSMahYDDJYefupJ51grzAf0uYVYefylCkwAZlMJ+zNeA/yHRe2F0p3ubA
         ooR2nQ2X6awzAWl8QK1K/Owhzn8vw4Yek3oM6sjuctt+qS+fqUiZsPbEAR330sWel7mZ
         v69rhijsg9CDtYYsgC3rrvisfW89pMjOmzzoAki8IKb2KZSN58LZxCm0YTCEo8EPfkiG
         +9BbjdTWGeKwHqEFl0Q+7Myq7GUbz1QjcJXDtas+d9SL/ePT50sArDG3S3APAdqv/POf
         Ejaw==
X-Gm-Message-State: AOAM532wHvGXIa2xJLujR3qgihGTxNquHNjsUjm71xKnW60es2StELsA
        I6nYOSV3Y/k8jp5S3Bas9HkcFLMeTSQ=
X-Google-Smtp-Source: ABdhPJxG1iKAeb8v8L6zyltHS9c2LW7VF7eo9mh/k8duc174LULFMOIhix5IulGAH7Wmp1IoIju7aw==
X-Received: by 2002:a50:c28a:: with SMTP id o10mr2231161edf.222.1605139593768;
        Wed, 11 Nov 2020 16:06:33 -0800 (PST)
Received: from ltop.local ([2a02:a03f:b7fe:f700:28a7:5fc2:f4ab:be33])
        by smtp.gmail.com with ESMTPSA id f3sm260833edl.23.2020.11.11.16.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 16:06:33 -0800 (PST)
Date:   Thu, 12 Nov 2020 01:06:31 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Sparse Mailing-list <linux-sparse@vger.kernel.org>
Subject: Re: [PATCH] linearize: fix a couple of 'selfcheck' warnings
Message-ID: <20201112000631.3e2ysn6zym2dg7oc@ltop.local>
References: <76afc97f-e6c3-2164-e4e1-13e850493af1@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76afc97f-e6c3-2164-e4e1-13e850493af1@ramsayjones.plus.com>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Wed, Nov 11, 2020 at 05:47:02PM +0000, Ramsay Jones wrote:

Thank you. How can I have forgotten these?

-- Luc
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
>  linearize.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/linearize.h b/linearize.h
> index 77ae7c9a..31c754e2 100644
> --- a/linearize.h
> +++ b/linearize.h
> @@ -326,8 +326,10 @@ pseudo_t undef_pseudo(void);
>  struct entrypoint *linearize_symbol(struct symbol *sym);
>  int unssa(struct entrypoint *ep);
>  void show_entry(struct entrypoint *ep);
> +void show_insn_entry(struct instruction *insn);
>  const char *show_pseudo(pseudo_t pseudo);
>  void show_bb(struct basic_block *bb);
> +void show_insn_bb(struct instruction *insn);
>  const char *show_instruction(struct instruction *insn);
>  const char *show_label(struct basic_block *bb);
>  
> -- 
> 2.29.0
