Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 931C8C5519F
	for <linux-sparse@archiver.kernel.org>; Sun, 22 Nov 2020 20:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DBBD206FB
	for <linux-sparse@archiver.kernel.org>; Sun, 22 Nov 2020 20:38:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mj8K40sn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbgKVUiE (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 22 Nov 2020 15:38:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727297AbgKVUiD (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 22 Nov 2020 15:38:03 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F1AC0613CF
        for <linux-sparse@vger.kernel.org>; Sun, 22 Nov 2020 12:38:03 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id s8so16567625wrw.10
        for <linux-sparse@vger.kernel.org>; Sun, 22 Nov 2020 12:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=A7MqUesU7U7SG4sAQdh4tWTV10X2Cxck9huKZPvaxzk=;
        b=mj8K40snDzVLf45RL3MNCAkNNZTT3fAZAlMHzkQ6zci6CpuJMYAb9qkX0YmyDoQJiy
         gkN+J7XhJsu0aFKgyCkk035tpCmfHRyPWv/gp3eGHr+Ebwg71HhNXJmONyaT1joVHpSf
         uTqNXc5AsHQS6tAnrjuRqQ57AVXYgxJNbN4mGVW+rnjh/fbNhX7nktYurJEZbk2qVULv
         2BAUuux0UtkBLd1oYNFv+SloAa6uBQAo/xvRrCQwUChgoZV/lwRkPo/zpL2EXUukO1eq
         Y22HjruQWacHzY0JGRJeN7V7EJesf2rtsVolC3sB+CBUxK4SZOeFT3G64xZtUBOOv6fo
         90Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=A7MqUesU7U7SG4sAQdh4tWTV10X2Cxck9huKZPvaxzk=;
        b=SoATS/5XTYBqCstWlu9jyybNr+Uht/QcJfdj2ixky1Z7NrEY0VwksbsOYdBiesxkP3
         JzurV4tLqVTUVarkZF75SQgjzAksMo4Ukhp4oKKySMkvLCDUvnN/BU7x5rFHMZPXtlfF
         b2vyubxe7XOAFdRfUAK/gF4vuKtAeM0XH2oZLL9rhdDWVEHNh63PEW9lIucHgcPHci72
         gsywlKxcmazZ9Qtw7Gtt338ruq3N//zk7RmjbcfozTSm7ptMh5eZsPVylEER0SULrG/l
         3KqtZYe4OxCuS4X+9bArqUu/+GworJO9Xoa25F0LIaFJqZAc5rhHs7BAAbZV1CQYyi7V
         1gww==
X-Gm-Message-State: AOAM531bkUnAUcRWTGCtqhH0ho6hDYIwhwsqQeEk26G61pXl3/r2MbOo
        bQkH9aMPaYZAJXvkG95mej1alBrNeiU=
X-Google-Smtp-Source: ABdhPJy4vei2lgTu5DlEB5F0W/cMOUVe4TjDs5Ms09urYVT67/CdXTsx1hBEMIbj5ZDiwMbQhC/MOg==
X-Received: by 2002:adf:8028:: with SMTP id 37mr27074340wrk.111.1606077481860;
        Sun, 22 Nov 2020 12:38:01 -0800 (PST)
Received: from ltop.local ([2a02:a03f:b7fe:f700:b0d0:6cd2:d2ec:fc3c])
        by smtp.gmail.com with ESMTPSA id p9sm3551930wrw.29.2020.11.22.12.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2020 12:38:01 -0800 (PST)
Date:   Sun, 22 Nov 2020 21:38:00 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sparse Mailing-list <linux-sparse@vger.kernel.org>
Subject: Re: [PATCH 1/7] not: add testcases for canonicalization &
 simplification of negations
Message-ID: <20201122203800.y262kn5hk3puvcbh@ltop.local>
References: <20201122152731.10994-1-luc.vanoostenryck@gmail.com>
 <20201122152731.10994-2-luc.vanoostenryck@gmail.com>
 <CAHk-=wjqwFDEJkGoPtjeTn1cDDpadz_eL_m1w-wk9G9Zmucosg@mail.gmail.com>
 <20201122195746.uq44lstsy2pissxi@ltop.local>
 <CAHk-=wjoJXrG=2_vnOX37fro12eyZc+uo2WL+F-utk51g9WuBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjoJXrG=2_vnOX37fro12eyZc+uo2WL+F-utk51g9WuBA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Sun, Nov 22, 2020 at 12:13:46PM -0800, Linus Torvalds wrote:
> 
> Honestly, particularly in the conditional form, the OP_SEL
> optimization might not even be the right thing. It adds register
> pressure.
> 
> So maybe a better model would be to not try to do jump-conversion, but
> have some kind of general "can we simplify phi nodes", where jump
> conversion to OP_SEL is just one of the options.

Yes, for the "context imbalance" problem, it's best to eliminate
the most possible conditional branches (and if-conversion and jump
threading help each other at this (when not blocking each other)).
So, yes, probably what's missing the most is some strategy to
attack the problem.

-- Luc
