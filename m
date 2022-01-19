Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73CA5C433EF
	for <linux-sparse@archiver.kernel.org>; Wed, 19 Jan 2022 00:03:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350332AbiASADj (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 18 Jan 2022 19:03:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:31280 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350320AbiASADi (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 18 Jan 2022 19:03:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642550618;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tVYvA6k75j8gln9tRsgy3BBh8Hq7EurwC1H6Kup6Uac=;
        b=g3EcQiM/e/lFDvp0/Sivwfg5+r0TS+z1CTV5i/rhLmnfMRhAXcuMHwi/ScFfJZ/tDVtJ96
        5iISZKg62zXx624F1McbTyN8gR4S5iDPSa1L+aYrNgHh5LOEOOTnfZI12tyN7Dksu3TBmx
        mRbpFztR//CuHPu8g4FOPQzbMW65i94=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-217-k6OrJjn4Myy3x9jX1ZyBLQ-1; Tue, 18 Jan 2022 19:03:36 -0500
X-MC-Unique: k6OrJjn4Myy3x9jX1ZyBLQ-1
Received: by mail-ot1-f69.google.com with SMTP id v22-20020a0568301bd600b00590a8d65e0fso309486ota.4
        for <linux-sparse@vger.kernel.org>; Tue, 18 Jan 2022 16:03:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tVYvA6k75j8gln9tRsgy3BBh8Hq7EurwC1H6Kup6Uac=;
        b=QrMDbwtnp7kbPZjxKfR7XNciXyTNcwtybaKitAEu9MJibJJaJ0gwykZiu2F0ZvPfI0
         U1NxocFSrvL4FxTWPPlbwRlZC+vBHaEZYsl9aZooK8eFdqOzLBHT7n/XV9/af2eQOI4k
         x584Hqkq8Qq+KOBd3hvg+CrOKFa7tcPNVxJeNtxEQK6FfLoGEPdEviDflqSh2D8kXm9P
         tHmdbzQ7kaXC5N7XkLOQUcWVk+SOyYEBiqZW/CzJ4t8d/yo2QOR/Tsk+KhDvqwirpAgO
         GnKyY9U+bSjGmvjmcBBZK+KtMxgxuu4fZnfcpapwB6PJF6jdvvUvYehJjt/iHDLTQmUH
         qOeA==
X-Gm-Message-State: AOAM532ul5jDEvCJJAHdoq3ZmJNOEyKYCY4792YeRXx5nFOEJups0nSa
        odV2QCULqXRZ04lrj45WOccx/rr3A/NoQOmdJtudN1jH/o3Pg2X17clPjTFNRPetcdW5hfJmnWY
        O+XnwKXjm6Rx39alhJJzgMhfk
X-Received: by 2002:a05:6830:2785:: with SMTP id x5mr22537883otu.187.1642550616007;
        Tue, 18 Jan 2022 16:03:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwFSVupUWPVUpDZy728lBKKhw+a+1HU1Pevbh8pLavUmbWJOKEDeq0ntl5K4b6WWPcLn98w6Q==
X-Received: by 2002:a05:6830:2785:: with SMTP id x5mr22537853otu.187.1642550615767;
        Tue, 18 Jan 2022 16:03:35 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::c])
        by smtp.gmail.com with ESMTPSA id ay40sm9106563oib.1.2022.01.18.16.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 16:03:35 -0800 (PST)
Date:   Tue, 18 Jan 2022 16:03:27 -0800
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
Message-ID: <20220119000327.oapghqad4lebnsra@treble>
References: <20220114010526.1776605-1-ndesaulniers@google.com>
 <YeQei0xNzMq7bFdg@zn.tnic>
 <20220118192256.jzk5dnceeusq7x7u@treble>
 <20220118230120.pivvson7qekfiqic@treble>
 <YedOLva0zos3A1JE@zn.tnic>
MIME-Version: 1.0
In-Reply-To: <YedOLva0zos3A1JE@zn.tnic>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jpoimboe@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Wed, Jan 19, 2022 at 12:33:02AM +0100, Borislav Petkov wrote:
> On Tue, Jan 18, 2022 at 03:01:20PM -0800, Josh Poimboeuf wrote:
> > With the two WARN_ONs in media_request_object_complete(), GCC apparently
> > considers the two reachable() asm statements as duplicates, and it
> > removes the second one.
> 
> Could that be the same thing:
> 
> net/xfrm/xfrm_output.o: warning: objtool: xfrm_output_resume()+0x2e0: unreachable instruction
> 
> I see two WARN_ONs in asm output there too...

If one of the '__bug_table' asm snippets isn't immediately followed by
the .L[un]reachable asm, then yeah, it's the same issue.


For example it's supposed to look something like this:


# 472 "net/xfrm/xfrm_output.c" 1
	1:	.byte 0x0f, 0x0b
.pushsection __bug_table,"aw"
2:	.long 1b - 2b	# bug_entry::bug_addr
	.long .LC4 - 2b	# bug_entry::file	#
	.word 472	# bug_entry::line	#
	.word 2307	# bug_entry::flags	#
	.org 2b+12	#
.popsection
# 0 "" 2
# 472 "net/xfrm/xfrm_output.c" 1
	.Lreachable1666:
	.pushsection .discard.reachable
	.long .Lreachable1666 - .
	.popsection


NOT just this:


# 472 "net/xfrm/xfrm_output.c" 1
	1:	.byte 0x0f, 0x0b
.pushsection __bug_table,"aw"
2:	.long 1b - 2b	# bug_entry::bug_addr
	.long .LC4 - 2b	# bug_entry::file	#
	.word 472	# bug_entry::line	#
	.word 2307	# bug_entry::flags	#
	.org 2b+12	#
.popsection
# some other code here...


There's a bunch of those throughout the code base.  The current
annotate_[un]reachable() implementations are carefully written to avoid
that happening.

-- 
Josh

