From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 5/5] sparse: Add end-to-end compiler shell script
Date: Mon, 22 Aug 2011 10:51:58 -0400
Message-ID: <4E526D0E.8030008@garzik.org>
References: <1314021451-24808-1-git-send-email-penberg@kernel.org> <1314021451-24808-5-git-send-email-penberg@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:51292 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751048Ab1HVOwC (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 22 Aug 2011 10:52:02 -0400
Received: by qyk38 with SMTP id 38so1369850qyk.19
        for <linux-sparse@vger.kernel.org>; Mon, 22 Aug 2011 07:52:01 -0700 (PDT)
In-Reply-To: <1314021451-24808-5-git-send-email-penberg@kernel.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pekka Enberg <penberg@kernel.org>
Cc: linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jgarzik@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>

On 08/22/2011 09:57 AM, Pekka Enberg wrote:
> This patch adds a 'kcc' shell script that combines the sparse's i386 backend
> with GCC and GNU assembler to make it easier for people to find bugs in sparse.
> You can, for example, attempt to build sparse with itself and see it crash and
> burn:
>
>    make&&  find . -name "*.o" | xargs rm
>    make CC=./kcc
>         CC       test-lexing.o
>    FIXME! no value for symbol preprocess_only.  creating pseudo 1 (stack offset 4)
>    {standard input}: Assembler messages:
>    {standard input}:79: Error: operand type mismatch for `mov'
>    make: *** [test-lexing.o] Error 1
>
> Cc: Christopher Li<sparse@chrisli.org>
> Cc: Jeff Garzik<jgarzik@redhat.com>
> Cc: Linus Torvalds<torvalds@linux-foundation.org>
> Signed-off-by: Pekka Enberg<penberg@kernel.org>

For the record, the i386 backend is quite incomplete and awful.

Ideally, an sparse compiler would work from linearized output, not from 
walking the tree as compile-i386 does.

	Jeff




