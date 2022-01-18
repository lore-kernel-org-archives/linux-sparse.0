Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A879C433F5
	for <linux-sparse@archiver.kernel.org>; Tue, 18 Jan 2022 19:23:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343526AbiARTXD (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 18 Jan 2022 14:23:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:41366 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245464AbiARTXC (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 18 Jan 2022 14:23:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642533782;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=szFzYuqp/rVABkm8mkSgMpFZFDViwmtCeMvEqr1ilK0=;
        b=NKK6g+RQnheEQSf63PfiBny359nUJ1pDUcHi2nO1/O4uuS6tNx6N/eBlb1TJ/TdBmN9PdO
        Na47DZc4LFoxxwRIyQlds9GxjaCL3XGGghJoHIpgSrtL6hhnl0nRnNpfLytliajODVwcNg
        1bGch9Ub2qJLJrBXZSCEfD+LiAs+Q+I=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-529-ei62zZI8PtGevSZqc4Utjw-1; Tue, 18 Jan 2022 14:23:01 -0500
X-MC-Unique: ei62zZI8PtGevSZqc4Utjw-1
Received: by mail-ot1-f71.google.com with SMTP id h15-20020a9d6f8f000000b005986ef3f50aso6069810otq.3
        for <linux-sparse@vger.kernel.org>; Tue, 18 Jan 2022 11:23:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=szFzYuqp/rVABkm8mkSgMpFZFDViwmtCeMvEqr1ilK0=;
        b=EYghRb7Nbfi2J3pJejHfWLK7Nq2uojLOTUHkoLR/ZNoQ/5yeKkGXXxUGdpwZ7qLhxY
         wYBBxc22aDq0VMtI9BgChGJPbyu4aidz6h1l3nwNkDn9+UsXarQwIvXEjEku3nYEChAP
         X3d7Moc6Gx0KezhcxX3czJaPCcyHRUBlS0qMnu2YN/atAluyYWqeI9SwrUhxiYII0raw
         sCkuJeHM+hxMjp1nUIAOXEtyjwYYsL0QHZAqgcxzb3uC5PNaAnQHQ3ERf7EDO7StS9C4
         xG0tTvM6FfxYVE1lkItm7CyOZBVurYVXrtKXnNOLhd0s+lSIgnw9heXW5Vlx+b4XawG1
         r/8w==
X-Gm-Message-State: AOAM531nX3YRlyP+X1l9Fumfa/Udsaup6xaQVMG4UMBtLBPScjyzsWKk
        pi81tTdzcPAvrvWXJonJZgJaDaJwcEXx/VNRKEpQtbK0bg75uzbxhb/PkiYai2OjHEXCfRvQ0xo
        V+lkz4D5qbo/9ObbmKrhmDoNJ
X-Received: by 2002:a05:6830:148f:: with SMTP id s15mr12549736otq.242.1642533779971;
        Tue, 18 Jan 2022 11:22:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwzr0wpP0kkTCgrhkGxkaIaWoXrzgt8LpYDiF/kTrxf2zstxk5uqrspsrdw765/b9E+vg16lA==
X-Received: by 2002:a05:6830:148f:: with SMTP id s15mr12549720otq.242.1642533779776;
        Tue, 18 Jan 2022 11:22:59 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::c])
        by smtp.gmail.com with ESMTPSA id i25sm7472390otl.8.2022.01.18.11.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 11:22:59 -0800 (PST)
Date:   Tue, 18 Jan 2022 11:22:56 -0800
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
Message-ID: <20220118192256.jzk5dnceeusq7x7u@treble>
References: <20220114010526.1776605-1-ndesaulniers@google.com>
 <YeQei0xNzMq7bFdg@zn.tnic>
MIME-Version: 1.0
In-Reply-To: <YeQei0xNzMq7bFdg@zn.tnic>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jpoimboe@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Sun, Jan 16, 2022 at 02:32:59PM +0100, Borislav Petkov wrote:
> so I like the local label and how it is more readable this way.
> 
> So, provided the memory clobber works (I wonder here if Josh has some
> concrete failing cases which could be tested with your version) and
> after the nitpicks have been addressed
> 
> Acked-by: Borislav Petkov <bp@suse.de>

I think Nick was already able to recreate the original issue.  I'll run
it through some more testing.

I wanted to make this change years ago, but couldn't because of legacy
toolchains.  Here's hoping this is the final solution for those @#$%^
macros.

Boris, thanks for looping Nick in, I should have done so to begin with.

-- 
Josh

