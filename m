Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE2BC2D0A3
	for <linux-sparse@archiver.kernel.org>; Mon,  9 Nov 2020 21:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 190F4206ED
	for <linux-sparse@archiver.kernel.org>; Mon,  9 Nov 2020 21:16:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V4otEIv5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729247AbgKIVQU (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 9 Nov 2020 16:16:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbgKIVQU (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 9 Nov 2020 16:16:20 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B50C0613CF
        for <linux-sparse@vger.kernel.org>; Mon,  9 Nov 2020 13:16:20 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id o20so10347310eds.3
        for <linux-sparse@vger.kernel.org>; Mon, 09 Nov 2020 13:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=JpKmAJeK75QC6qa5f0PHRZqTSiS9sLhre4iDSIJ7zYo=;
        b=V4otEIv5f7V8MCqNO0GAM02wmWejAPnoPclJ9ywKepPCnApKpOM1TB7cVYvxtMglkw
         HWcYpcjqcJgwx4ytOJlV+B7sf/ob5KWy5tOvut08Y/RPdu2Ozy3yYK+il4Yj4Nrb8kxu
         d/XCVg3Z2Dl1nNJ902OnJYn23d6HFCJaXwFlEmCzdfK1X14kOWnMSLlf2MXtRHGyG5x5
         BpHVwsazon3zn1jMPGtRKjWSYoFMRVX27zskFf3Auvg6FxXRSTFw8+LHMTCl/uhfCoKf
         XctalQEc9x6/TkFsxZ2TY1rmV7cZ2gumkc8LcpYtv/83bJjlgDnNgW738D2Xm1X6mqlS
         lbIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=JpKmAJeK75QC6qa5f0PHRZqTSiS9sLhre4iDSIJ7zYo=;
        b=Gw6qSDOMpxX4NFTQ9/lbNTdrAjKJOjPIHg6euIjTiW96WoBtcIMEucH95qnH56Pj49
         s3IJ/MKBHWImlTwn6RWsTMUxaMi2OI4XXqqflMQ0xHgsYqoXqoGLEMCRYjHqGGT60u7M
         E2c4kQRiq8qpUlSZ3dYjxKSQ4YnUcMDpAFpPCU1fOKeJUuI+Gu0XzVeO5fUuiyVk9c59
         EwEUFkVRMMGr07FlvCJXZdP61x2eLv37vr4BGlCN+AaKfY0b2TfEBmyCiV1Xf8NRHpxJ
         ROQD7KwK44YAePBBilZ0Pr2LVjKSMCKM0PX9rC1zhy0MnP32TxlsdccmoqixntD4DsWQ
         v83g==
X-Gm-Message-State: AOAM5338Xd1m8FcEnSSJQ3FdDfjkJO5saiswwuE+jc0pbkf1ZkxvjSG0
        dnf7lOlL899xGaNZjEJ/a2+Jdq8Av2M=
X-Google-Smtp-Source: ABdhPJwTjr3TsrFbG/8T5fzbSkBvW+yPHlHgFnaUXAlncmGM5esHkwPWpedUvBD1sZ4VRRVLDqH1kQ==
X-Received: by 2002:aa7:c597:: with SMTP id g23mr17510775edq.184.1604956578449;
        Mon, 09 Nov 2020 13:16:18 -0800 (PST)
Received: from ltop.local ([2a02:a03f:b7fe:f700:b825:8815:5c02:9524])
        by smtp.gmail.com with ESMTPSA id s3sm9369175ejv.97.2020.11.09.13.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 13:16:17 -0800 (PST)
Date:   Mon, 9 Nov 2020 22:16:16 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: 'context imbalance' warnings
Message-ID: <20201109211616.dyr7g62rz5oohseu@ltop.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Hi,

This is the continuation of last week thread.

I've added a few more simplifications for selects & compares on top
of those from last week. Alas, none of these makes any real difference:
in my usual tests I have just one warning less (total number is now 995):
   * fs/dcache.c:1226:24: warning: context imbalance in 'dentry_lru_isolate_shrink' - different lock contexts for basic block

But well, these simplifications are good and can help.

So, I've taken again a look at the origin of these warnings (I already
did this 2-3 years ago). Here is what I found for the 6 first ones:

1) intel_{start,stop}_scheduling()
   - take/release a lock conditionally
   - but intel_start_scheduling() returns void ...

2) get_locked_pte()
   - it's a conditional lock
   - some code assume it never fails
   - some code protect it by a [VM_]BUG_ON()
   - sparse complains

3) lock_vector_lock()
   - OK, but the annotation is missing, I'll send a fix

4) raw_spin_trylock()
   - on UP, raw_spin_trylock() takes the context twice ...
   - I'll see what can be fixed there

5) acpi_os_read_memory()
   the usage pattern is 'interesting':

	flag = 0;
	lock();
	addr = lookup();
	if (!addr) {
		unlock()
		addr = map();
		if (!addr)
			return ERROR;
		flag = true;
	}

	// sparse complains here

	... use addr ...

	if (flag)
		unmap(addr);
	else
		unlock();
	return 0;

   I see the pattern and I suppose the locking is correct but I
   think that sparse's warning is justified. Is it needed to do
   the early unlock() when the lookup fails?

6) clk_enable_lock() (@ drivers/clk/clk.c)
   This one is really interesting and shows one of Sparse's shortcoming

	if (!spin_trylock_irqsave(&lock, flags)) {
		if (some_test) {
			__acquire;
			local_save_flags(flags);
			return flags;
		}
		spin_lock_irqsave(&enable_lock, flags);
	}
	...
	return;

   So the code is correct but what sparse really sees is:

	flags = __raw_save_flags();
	cli;
	tmp = _raw_spin_try_lock();
	if (tmp)
		__acquire;
	else
		__raw_restore_flags(flags);

	// sparse complains here

	if (!tmp) {
		if (some_test) {
			__acquire;
			flags = __raw_save_flags();
			return flags;
		}
		flags = raw_spin_lock_irqsave();
	}
	...
	return flags;

   Now sparse could merge the two branches depending on tmp,
   as if the code would have been written as:

	flags = __raw_save_flags();
	cli;
	tmp = _raw_spin_try_lock();
	if (tmp)
		__acquire;
	else {
		__raw_restore_flags(flags);
		if (some_test) {
			__acquire;
			flags = __raw_save_flags();
			return flags;
		}
		flags = raw_spin_lock_irqsave();
	}
	...
	return flags;

   But the corresponding IR is:

	... %r9(flags) <- ...			// flags = __raw_save_flags();
	...					// cli();
	call.32	%r10(tmp) <- _raw_spin_trylock	// tmp = _raw_spin_try_lock();
	cbr	%r10(tmp), .L1, .L2		// if (tmp)
.L1:	context	1				//   __acquire;
	br	.L3
.L2:	<restore interrupts>			//   __raw_restore_flags(flags);
	br	.L3
.L3:	phisrc.32 %phi1(flags) <- %r9(flags)
	cbr	%r10(tmp), .L4, .L5		// if (!tmp)

   The presence of the phisrc at .L3 blocks the BB merging.
   But this is only part of the problem. First:
   1) The phisrc (and maybe the associated phi-node) could
      be moved/adjusted when merging the BBs
   2) phisrcs are not really needed anyway (they're just a
      mean to track the BB of each phi-node's arguments).

   But even without these phi-sources, some merging that could
   happen doesn't.  For example, code like:
	#define __acquire	__context__(X, 1)
	int  def(void);
	void use(int);
	int foo(int a)
	{
		int tmp = def();
		if (a)
			__acquire;
		else
			use(tmp);
		if (!a) {
			def();
			__acquire;
		}
		use(0);
		__release;
		return tmp;
	}

   produces:
	foo:
	.L0:	call.32     %r1 <- def
		cbr         %arg1, .L1, .L2
	.L1:	context     1
		br          .L3
	.L2:	call        use, %r1
		br          .L3
	.L3:	cbr         %arg1, .L5, .L4	;; false imbalance here
	.L4:	call.32     %r7 <- def
		context     1
		br          .L5
	.L5:	call        use, $0
		context     -1
		ret.32      %r1

   There is no phi-source here and the CBR at .L3 could be merged
   with the one at .L0, removing the false imbalance but it's not.
   I thought that sparse was doing this sort of branch simplification
   but it doesn't, or at least it doesn't in this (simple) situation.

   I'll begin to look at this. I'm not sure about a general solution
   but for a simple case like here (just a 'diamond') it seems simple
   enough to handle.

-- Luc
