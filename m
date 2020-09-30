Return-Path: <SRS0=NWui=DH=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D62AC4727C
	for <linux-sparse@archiver.kernel.org>; Wed, 30 Sep 2020 20:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 009272076A
	for <linux-sparse@archiver.kernel.org>; Wed, 30 Sep 2020 20:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lZxYrSzE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725892AbgI3U3i (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 30 Sep 2020 16:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbgI3U3i (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 30 Sep 2020 16:29:38 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8AAC061755
        for <linux-sparse@vger.kernel.org>; Wed, 30 Sep 2020 13:29:38 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id e17so809618wme.0
        for <linux-sparse@vger.kernel.org>; Wed, 30 Sep 2020 13:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wvcjIxlBwNjoMSpbZ7w2RXmyMLWMXqvsxzx9cSoSeRw=;
        b=lZxYrSzE7Rjhrdkb4S7SVtl9yVSIiea8czYIqA4JNe0ObGpHfrsICaXis8K2Ejrf6i
         aMqrcO61xSZHovsFGiuthZpilxnDTBYoV1enF+SbW/T1M+U6SWR4hgaeH+/VaBEXg0rr
         0WTdBs0zHJeCM2kYjd5gA0tdMyKc0gM5ziQmAYzUz7wuoO0BW0+IQ2+0jkUqZWc29K3P
         iglwUgihsflu878Dx6QVZiFChFHI7h3/sVlVkJvY6Bq03hHqq/waUurojWx4i/wgqNKP
         ZdI5VL5x+vg5D4UNwJw59wuyr0T6k6M9hlb4ncQqDjMCoLFmb4j2WNCvJ+UbMkkx6c75
         bS/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wvcjIxlBwNjoMSpbZ7w2RXmyMLWMXqvsxzx9cSoSeRw=;
        b=iKGWYoQ21FGNW5z84OLgpPyo0Jy/DC3Jiq7/jtwaeMz2zQS5rRlBIZTAWx4P70joO9
         wxOY3oIRCJJwVqf61yTL5BybY6dH+Wiocegx1f5ieE8bdCkQ42XPm5VZfOkJRCUY7LJd
         ptuAMGZR9k3dZWFC8geDC/Gqo+26qOHu6M6ZBuLFlH0Gte/ofaQ3e7Z8lAFv0S71O+Dk
         AfNGtWID9jb3X5YSe+rKOKuzhiAHSi92cH1tGKKe8lMpX6tLd74V4EDXvYZimQn0uKgx
         5MJPr1/CTr4mgqBGgxneigpGVlGUtxOk5RvVgnFLM5atJLYeXmc2NkUzPCjvQhmD6D9j
         6mtQ==
X-Gm-Message-State: AOAM530r+Y0gt/ml5VZPsUNXuDz3av6JN1VTArO6dHFtCLvrXlfrS52r
        NfFTgngugojoYmpRyttVcaukB9bssbY=
X-Google-Smtp-Source: ABdhPJyMDb91DpO+PnWgq6ZZiwXZ9OfY1JANPVsv+IbaIHm8Od3xvF72ZGvX6soVk5DdE3HroNkE/Q==
X-Received: by 2002:a7b:ce96:: with SMTP id q22mr4521296wmj.132.1601497775915;
        Wed, 30 Sep 2020 13:29:35 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:b7fe:f700:d0c8:dbcc:51b0:75b9])
        by smtp.gmail.com with ESMTPSA id w2sm4784983wrs.15.2020.09.30.13.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 13:29:34 -0700 (PDT)
Date:   Wed, 30 Sep 2020 22:29:34 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     linux-sparse@vger.kernel.org
Subject: Re: update to format parsing branch
Message-ID: <20200930202934.rjcfxikrzfvesxnc@ltop.local>
References: <3960bea7-69ef-ed00-66cf-ac73d5cd8876@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3960bea7-69ef-ed00-66cf-ac73d5cd8876@codethink.co.uk>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Wed, Sep 30, 2020 at 09:35:50AM +0100, Ben Dooks wrote:
> I've done a rebase to v0.6.2 and put the result up at:
> 
> https://gitlab.com/CodethinkLabs/sparse bjdooks/printf-new3

Great.
It just needs a few very mnor changes:

%% diff --git a/evaluate.h b/evaluate.h
%% index a16e97036b2a..bb8ec480691c 100644
%% --- a/evaluate.h
%% +++ b/evaluate.h
%% @@ -26,10 +26,14 @@ struct symbol *evaluate_statement(struct statement *stmt);
%%  // @list: the list of the symbol to be evaluated
%%  void evaluate_symbol_list(struct symbol_list *list);
%%  
%% -///

This is the marker for autodoc, so it needs to stay.

%%  // evaluate the arguments of a function
%% +// @fn: the symbol of the prototype
%%  // @argtypes: the list of the types in the prototype
%%  // @args: the list of the effective arguments
%% -int evaluate_arguments(struct symbol_list *argtypes, struct expression_list *args);
%% +int evaluate_arguments(struct symbol *fn, struct symbol_list *argtypes, struct expression_list *args);
%%  
%% +// check if assignment types are compatible
%% +// todo

I've removed the 'todo'

%% diff --git a/parse.c b/parse.c
%% index 31ecef0f554d..a7ab5fd6e531 100644
%% --- a/parse.c
%% +++ b/parse.c
%% @@ -377,6 +383,10 @@ static struct symbol_op attr_force_op = {
%%  	.attribute = attribute_force,
%%  };
%%  
%% +static struct symbol_op attr_format = {

To stay coherent with existent naming, I've rename this into 'attr_format_op'

%% @@ -515,6 +535,7 @@ static struct init_keyword {
%%  	N("_Float64",		&spec_op,	.type = &float64_ctype),
%%  	N("_Float64x",		&spec_op,	.type = &float64x_ctype),
%%  	N("_Float128",		&spec_op,	.type = &float128_ctype),
%% +

Removd unneeded line.

%% @@ -551,6 +572,9 @@ static struct init_keyword {
%%  	D("pure",		&attr_fun_op,		.mods = MOD_PURE),
%%  	A("const",		&attr_fun_op,		.mods = MOD_PURE),
%%  	D("gnu_inline",		&attr_fun_op,		.mods = MOD_GNU_INLINE),
%% +	N("format",		&attr_format),
%% +	N("printf",		&attr_printf_op),
%% +	N("scanf",		&attr_scanf_op),

I've changed the 'N' into 'D' since the underscore versions are legit and
often favored.

%% diff --git a/sparse.1 b/sparse.1
%% index 48dab7a9a5c1..e46aafdb3e5e 100644
%% --- a/sparse.1
%% +++ b/sparse.1
%% @@ -275,6 +275,15 @@ trouble.
%%  Sparse does not issue these warnings by default.
%%  .
%%  .TP
%% +.B \-Wformat
%% +Warn about parameter mismatch to any variadic function which specifies
%% +where the format string is specified with the 
%% +.BI __attribute__((format( type, message, va_start )))
%% +attribute.
%% +
%% +Sparse does not issue these warnings by default. To turn them on, use
%% +\fB\-Wno\-format\fR
%% +.TP

I've moved this one position above, between '-Wexternal-...' and -Winit-..
to keep the alphabetical order, removed some unneeded whitespace and
added a final dot.

%% diff --git a/symbol.h b/symbol.h
%% index a3ed95678ee5..47e26816430c 100644
%% --- a/symbol.h
%% +++ b/symbol.h
%% @@ -84,6 +84,7 @@ enum keyword {
%%  	KW_STATIC	= 1 << 7,
%%       // KW UNUSED	= 1 << 8,
%%  	KW_EXACT	= 1 << 9,
%% +	KW_FORMAT	= 1 << 10,
%%  };

I've just reused the UNUSED slot.


I've also exchanged patch 3 & 4 because the 3rd needed the definition of
Wformat only added in patch 4 and fixed 2 or 3 typos in the commit messages. 
I've pushed these changes at gitlab.com/lucvoo/sparse-dev format-check

I've left for now the changelog parts in the commit messages but I would
prefer to not have them in the final version.

> Should I put this through a new round of review?

I'm fine with the changes (moving the check to a verify-format.c +
some changes related to excessively long lines).

I've one last request, the email address given as author is not the same
as the one used in the Signed-off-by and the copyright notice.

So, is it possible to respin the series with:
* the small changes I've made here above
* removing the changelogs from the commit messages
* using the same email address for the author and the SoB?

Thanks,
-- Luc
