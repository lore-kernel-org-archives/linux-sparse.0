Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29509C433F5
	for <linux-sparse@archiver.kernel.org>; Tue, 18 Jan 2022 23:01:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350131AbiARXB2 (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 18 Jan 2022 18:01:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:51880 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350114AbiARXB1 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 18 Jan 2022 18:01:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642546886;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=imSbjfG3HpJVgHUztBteAKnTWeE4AQAds5w4lniIVaU=;
        b=glt8S3+sl5nQWqEhmmUxb6hzFrTqIFeA28MfjXx+uP9QBDEOUon8Kr5P4I5WwfA/2Y61dq
        vxRS9t/XJ0O8tYI0dSXHbAFLZgzCwkOz9qBTsrWSTX5UkQbg/urQKisQYkyDtH+SYPoVko
        cSA77K4RuZG0iDFB1hF9pDpaqzbuqsY=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-537-QKyUdb-2O--SdT2IrYuqHA-1; Tue, 18 Jan 2022 18:01:25 -0500
X-MC-Unique: QKyUdb-2O--SdT2IrYuqHA-1
Received: by mail-qv1-f70.google.com with SMTP id jn6-20020ad45de6000000b004146a2f1f97so681940qvb.19
        for <linux-sparse@vger.kernel.org>; Tue, 18 Jan 2022 15:01:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=imSbjfG3HpJVgHUztBteAKnTWeE4AQAds5w4lniIVaU=;
        b=208dvGpt2ipSSf87egBePe7VCvqCaQvG+025YZ1S2WUZLcXjhWDmNVKQKYAtGxWwet
         MKQAsZ941ij5d1azEjKQH2rTusm3O2FZHGPQfRPZbMiiZoM35Vqm3OtxeM0jT6e+JjxI
         orFrdbn/PF98ry1nrFXKMSsnj4Kodn+nCc2D6w0n5xZFRntXF3fNayYuFI6MQTW+4/AI
         BXF/qVU3a6wwWYb8bdZjn54wJMA2PKvzW1InfBVA2DJVdeMHo6BF5+rv2ZIsUKcCJGTn
         7m3JWHkr96F7xr25QF/q3Rqg7J+iXN+wOWO2b2odp34Ud6GzDLDJYjmrTwIjvc6ebCwh
         mgKQ==
X-Gm-Message-State: AOAM533dpll1i8Gltnufvw/If+5m4+2MGBTksssViw2SCMtaKhnvQaY2
        /NM7KakUE35/f8NhK3wZbClkpMabMnuIgN+dmsx+okCShTnZU6JiXQLLuVFSPY9v6XUh5TyBzoW
        yJiqpFzPBQQ8rEmPY24KOW6XS
X-Received: by 2002:ac8:57d6:: with SMTP id w22mr9729198qta.167.1642546884605;
        Tue, 18 Jan 2022 15:01:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxyQ926lYNQFaaESs3XDeB0TGuTp5YmiFt/PM6FFwVllm13rgEx76LTNmglnZnmxg9ERdqTBA==
X-Received: by 2002:ac8:57d6:: with SMTP id w22mr9729170qta.167.1642546884378;
        Tue, 18 Jan 2022 15:01:24 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::c])
        by smtp.gmail.com with ESMTPSA id i5sm4598139qkn.19.2022.01.18.15.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 15:01:23 -0800 (PST)
Date:   Tue, 18 Jan 2022 15:01:20 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        x86@kernel.org, llvm@lists.linux.dev, linux-sparse@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH] objtool: prefer memory clobber & %= to volatile &
 __COUNTER__
Message-ID: <20220118230120.pivvson7qekfiqic@treble>
References: <20220114010526.1776605-1-ndesaulniers@google.com>
 <YeQei0xNzMq7bFdg@zn.tnic>
 <20220118192256.jzk5dnceeusq7x7u@treble>
MIME-Version: 1.0
In-Reply-To: <20220118192256.jzk5dnceeusq7x7u@treble>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jpoimboe@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Tue, Jan 18, 2022 at 11:22:59AM -0800, Josh Poimboeuf wrote:
> On Sun, Jan 16, 2022 at 02:32:59PM +0100, Borislav Petkov wrote:
> > so I like the local label and how it is more readable this way.
> > 
> > So, provided the memory clobber works (I wonder here if Josh has some
> > concrete failing cases which could be tested with your version) and
> > after the nitpicks have been addressed
> > 
> > Acked-by: Borislav Petkov <bp@suse.de>
> 
> I think Nick was already able to recreate the original issue.  I'll run
> it through some more testing.
> 
> I wanted to make this change years ago, but couldn't because of legacy
> toolchains.  Here's hoping this is the final solution for those @#$%^
> macros.
> 
> Boris, thanks for looping Nick in, I should have done so to begin with.

Apparently this patch isn't going to work after all :-(

  https://lkml.kernel.org/r/202201190632.lhlaiCBk-lkp@intel.com

With the two WARN_ONs in media_request_object_complete(), GCC apparently
considers the two reachable() asm statements as duplicates, and it
removes the second one.

-- 
Josh

