From: Xi Wang <xi.wang@gmail.com>
Subject: Re: [RFC][PATCH 0/3] implement pseudo->ctype
Date: Sat, 9 Jun 2012 07:52:13 -0400
Message-ID: <2055A8E4-5846-4913-9E57-5BBDCB868284@gmail.com>
References: <1338792878-25898-1-git-send-email-xi.wang@gmail.com> <AE56D25F-20CE-49E3-90F8-2D80CA8CE4C9@gmail.com> <CAOJsxLGcqYO_H7vYB9Oku1s_3Nz9txytaB6ZjKCQ58o5G82Wag@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:39921 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751396Ab2FILwQ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 9 Jun 2012 07:52:16 -0400
Received: by yenm10 with SMTP id m10so1794857yen.19
        for <linux-sparse@vger.kernel.org>; Sat, 09 Jun 2012 04:52:16 -0700 (PDT)
In-Reply-To: <CAOJsxLGcqYO_H7vYB9Oku1s_3Nz9txytaB6ZjKCQ58o5G82Wag@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pekka Enberg <penberg@kernel.org>
Cc: linux-sparse@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Christopher Li <sparse@chrisli.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Jun 9, 2012, at 6:42 AM, Pekka Enberg wrote:
> Interesting. What are you planning to do with "splay"? Is there
> something that prevents fixing the current LLVM backend in master?

Just did this to try the new ->ctype in pseudo.  I don't want to
maintain another llvm backend for sparse. :-)

BTW, I feel like LLVM's C interface is very incomplete.  I had to
wrap some code in C++.

Besides, the phi nodes in sparse and LLVM are different.  LLVM's
phi 1) requires one entry for each predecessor, and 2) must stay
at the beginning of a block.  I didn't find an easy way to translate
sparse's phi to LLVM's, so instead generated load/store for phi
nodes.

- xi
