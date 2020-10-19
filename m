Return-Path: <SRS0=6y8R=D2=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A1EC433DF
	for <linux-sparse@archiver.kernel.org>; Mon, 19 Oct 2020 04:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27F5D2224D
	for <linux-sparse@archiver.kernel.org>; Mon, 19 Oct 2020 04:44:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IDz2WseC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbgJSEom (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 19 Oct 2020 00:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbgJSEom (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 19 Oct 2020 00:44:42 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57CD9C061755
        for <linux-sparse@vger.kernel.org>; Sun, 18 Oct 2020 21:44:42 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id u8so11993131ejg.1
        for <linux-sparse@vger.kernel.org>; Sun, 18 Oct 2020 21:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9A4KHupmvJOamyC2snB+6FBXbH9CYSawzjbv3kyBcXo=;
        b=IDz2WseCtlBt1BlUSTihA1jK/6bs3Jg2/h6ZIDHwVJXKdpIHJ2S3SpjZRPG0GbYh03
         hlWH1iMhX7w/j3/+SOwSwKRuYlzwC8h8bJ+nikZgi8VQVLsu8JlvPbi9Zq3FHRNbsUc+
         mlmCEWKzuim1s9+r5nWjN0jda4RWdaWyW+uC5Bp/CNPjE8pJYoleO0y7gnFQW7hb/+eA
         0Kk81Ox317unmH/kolM9zbS13XlG7+D0zZ3fn1DXLibxw+xXrmsLdWUVn7F5mPtVw97Q
         29esnUah8pAdNG9ATwab5tc5JIKUErW0fJuHIA23wTqx9AbyJW+E7+TNUodEYwwnFEzW
         ML1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9A4KHupmvJOamyC2snB+6FBXbH9CYSawzjbv3kyBcXo=;
        b=YBZe7UeaIYFGNFF4py+CgvsN9Ca/iMsh/xuzvPY5M1KQ0HXDeUKaOnHUt+DpuLzP3s
         +4AryYhxbsHz/HT50cjCL0J5abvEk+2xYMEjA/NpVvSIgKnT54iVALLUnCpVVzCs2bgd
         I66fRgXl0ix/oaJalryqsluj4MN//ORk4L7JwQid9xDs4FsK+rNkhp8c+Lk735DY3A91
         EMdRNuJpU6h1wKTFok7w2DObypJnkMl47xEnkTRi7ieNcYCmlCybxDKLyT6L6vewv5oV
         GqU7TM+AvsxVk/JI6GlYbZ5vPwovq4PttfSrS9HSrtZzLqFbaej0tM1d5V7hcxvyWyww
         JkyQ==
X-Gm-Message-State: AOAM530DN8sg2Qelb7ql4759Fk5mzVSWUCxtTBCwrZPD77iOViiR1LZb
        HHZmrqa1sxu4s97cyyINLysWexIEF5Y=
X-Google-Smtp-Source: ABdhPJxP/3gowq3D6CqWH11Kp1G2tOiGY1Q0fayAOQvO8gHn3xg3eezzbeOdk8zKG9Wg2eolesxmig==
X-Received: by 2002:a17:906:82c5:: with SMTP id a5mr15880250ejy.173.1603082680983;
        Sun, 18 Oct 2020 21:44:40 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:b7fe:f700:159c:4578:7f8d:4dab])
        by smtp.gmail.com with ESMTPSA id k10sm9256700ejh.32.2020.10.18.21.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2020 21:44:40 -0700 (PDT)
Date:   Mon, 19 Oct 2020 06:44:39 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     linux-sparse@vger.kernel.org
Subject: Re: [PATCH 04/12] builtin: evaluate __sync_*_fetch*()
Message-ID: <20201019044439.pcj7ucxjfm762tx4@ltop.local>
References: <20201017225633.53274-1-luc.vanoostenryck@gmail.com>
 <20201017225633.53274-5-luc.vanoostenryck@gmail.com>
 <c19eba37-af33-a852-a286-a6ecf23d77ea@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c19eba37-af33-a852-a286-a6ecf23d77ea@ramsayjones.plus.com>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Mon, Oct 19, 2020 at 12:59:01AM +0100, Ramsay Jones wrote:
> On 17/10/2020 23:56, Luc Van Oostenryck wrote:
> > diff --git a/builtin.c b/builtin.c
> > index 880dd54f647e..5e490830e147 100644
> > --- a/builtin.c
> > +++ b/builtin.c
> > @@ -627,23 +627,23 @@ static const struct builtin_fn builtins_common[] = {
> >  	{ "__builtin___vsnprintf_chk", &int_ctype, 0, { &string_ctype, size_t_ctype, &int_ctype, size_t_ctype, &const_string_ctype, va_list_ctype }},
> >  	{ "__builtin___vsprintf_chk", &int_ctype, 0, { &string_ctype, &int_ctype, size_t_ctype, &const_string_ctype, va_list_ctype }},
> >  
> > -	{ "__sync_add_and_fetch", &int_ctype, 1, { &ptr_ctype }},
> > -	{ "__sync_and_and_fetch", &int_ctype, 1, { &ptr_ctype }},
> > +	{ "__sync_add_and_fetch", NULL, 1, { vol_ptr, &dyntype }, .op = &atomic_op },
> > +	{ "__sync_and_and_fetch", NULL, 1, { vol_ptr, &dyntype }, .op = &atomic_op },
> 
> Hmm, I get that the return type is derived from the type of the first
> argument, but I don't see where that return type is checked/assigned
> to the function return type. :( So, why are these set to NULL, but ...
> 
> >  	{ "__sync_bool_compare_and_swap", &bool_ctype, 1, { vol_ptr, &dyntype, &dyntype }, .op = &atomic_op},
> 
> ... this one isn't?

Well, yes, __sync_bool_compare_and_swap() is defined as returning a bool,
so it can directly specified here. For the other functions, for example
__sync_add_and_fetch(), the return type must indeed be deduced form the
type of the first argument. It is set at the end of eval_atomic_common()

	if (!expr->ctype)       // __sync_val_compare_and_swap()
                expr->ctype = ctype;

The comment should be removed or replaced by a real one.

I'll clarify that. Thanks for noticng this.
-- Luc
