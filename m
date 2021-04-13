Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81956C433B4
	for <linux-sparse@archiver.kernel.org>; Tue, 13 Apr 2021 16:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52D8661220
	for <linux-sparse@archiver.kernel.org>; Tue, 13 Apr 2021 16:44:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbhDMQoR (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 13 Apr 2021 12:44:17 -0400
Received: from mail-ej1-f47.google.com ([209.85.218.47]:37610 "EHLO
        mail-ej1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346890AbhDMQoE (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 13 Apr 2021 12:44:04 -0400
Received: by mail-ej1-f47.google.com with SMTP id w3so27037864ejc.4
        for <linux-sparse@vger.kernel.org>; Tue, 13 Apr 2021 09:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gBDwmXzHtvaTA4KOZdhaJScM0gbOatpqMmOkQfI7g1U=;
        b=Ftf4e4jlKDPMW6Eg1ShgwWwXoE/x15Kr4/Sq7C6rKIra9ZsQ1Dku5dcik1ymMYPov3
         3uixs7Mq1Zy5WcsITFxUlpsCEmHtGZfE7zUYAnTRsCSbel9tuabbVZBMysBmoZLiBbnb
         DBwhT97/LWoht01Vngirt9KNLqgoIiGnHox3QTNfdxU323CEuB4K4ZWZ8/RQjcuOE44w
         BvQURh2lhJdhm9WuCEY48MW3SbPhdxdpWjd91bS4KSbmRD+Eq5guCIKtfNYj1De7vm8n
         7UplDCDTLuv3nqOlkxs3e4j2DBX7gDyjJn4qXYglSKOJPOo3PLlHzWr4lQwMdUCMYlYW
         8Qww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gBDwmXzHtvaTA4KOZdhaJScM0gbOatpqMmOkQfI7g1U=;
        b=VCjvw5h63jHGbVVyY7I1M1Ea/wAmkCdjJoFGM9/b8sHu87V+go09A7mm5qfJ5dXj5g
         Z3mENTH7f46C7shz9F3nH67Yl2eMeicwiUpkJRyxLofEXHQVoHiORCmB26ldQtTVF6qs
         +birfTcqxF4uxMBzHV570wmyq6nOG2d6QQYUQeqtQOLGQZHe7KU2UqbVhmS8n5PcYLF5
         F0dos2KAVs74ynSmhW05R4NUZWYW22ICeqo8ikHABMh0Wt2pLBerhQZ2a9kDsKrVILUR
         pgEKhwP/UHvxYbOGFMIIpkUsHCsqctleM8ILWYzPy2T+ixv1ckD9rz4JchgMeJPUV8ae
         u2gA==
X-Gm-Message-State: AOAM532VdOd9k75u/ZgEvkeEPer73xV52D848rL2F1ZpyU20tfX1VYHS
        d/m8azkQyhWBZTpPOzOBf9mJjTsfG+U=
X-Google-Smtp-Source: ABdhPJwdu1BJlFH8Ns8nuQGz0EfBCkyH09xLiSlHgovObSRg3sRBdKCe3wNBzWJ9aRB+tJBbP+hOQg==
X-Received: by 2002:a17:906:c283:: with SMTP id r3mr6244216ejz.328.1618332163705;
        Tue, 13 Apr 2021 09:42:43 -0700 (PDT)
Received: from mail ([2a02:a03f:b7fe:f700:6d14:80f0:1984:a98c])
        by smtp.gmail.com with ESMTPSA id a24sm5978692ejr.58.2021.04.13.09.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 09:42:42 -0700 (PDT)
Date:   Tue, 13 Apr 2021 18:42:41 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     linux-sparse@vger.kernel.org
Subject: Re: [PATCH v2 2/8] builtin: define a symbol_op for a generic op
 acting on integer
Message-ID: <20210413164241.wtmzkgdkyqjusova@mail>
References: <20210412212111.29186-1-luc.vanoostenryck@gmail.com>
 <20210412212111.29186-3-luc.vanoostenryck@gmail.com>
 <6d23e861-782e-de66-7ce7-76ff149d4a60@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d23e861-782e-de66-7ce7-76ff149d4a60@ramsayjones.plus.com>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Tue, Apr 13, 2021 at 01:23:00AM +0100, Ramsay Jones wrote:
> On 12/04/2021 22:21, Luc Van Oostenryck wrote:
> > +	int n = 0;
> > +
> > +	PREPARE_PTR_LIST(fntype->arguments, t);
> > +	FOR_EACH_PTR(expr->args, arg) {
> 
> Hmm, now n is always 0 in the error message, so:
> 		n++;
> here?

Hehe, yes indeed.
 
> > +		if (!is_dynamic_type(t)) {
> > +			;
> > +		} else if (!ctype) {
> > +			// fist 'dynamic' type, chat that it is an integer
> 
> s/chat/check/

fixed.

> > +	return evaluate_arguments(types, expr->args);
> 
> Hmm, does this do the usual argument promotions, so e.g. an 'generic'
> 'short' gets promoted to 'int' in the prototype? I guess not, that
> would have to be done above, while adding to the types list, right?

Well, evaluate_arguments() is the normal function used to evaluate
the arguments of all function calls, so, yes, it does arguments
promotion but only when the type is not specified (so either the
'...' of varadic function or an argument of a variadic builtin's
which is declared as NULL in the corresponding struct builtin_fn
(non-variadic builtins can't have such NULL arguments because the
first NULL is used to determine its arity and this is then normaly
checked in the .args method before the evaluation)).

> Hmm, I would have to study evaluate_arguments(), but it may be worth
> a comment here?

Not here, because there is nothing special but sure, evaluate_arguments()
should be documented and even more so how struct builtin_fn should be
used (because it's much more complex since a lot of builtins doesn't
follow the way normal C declarations rules).

> 
> So, this certainly looks better. Thanks! ;-)

Thanks to you!
-- Luc
