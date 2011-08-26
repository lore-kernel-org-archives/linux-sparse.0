From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 2/5] sparse: Enable unhandled validation tests
Date: Thu, 25 Aug 2011 20:42:54 -0700
Message-ID: <CANeU7QkykP-5cfgtQvQ5Sa69uxSu9QBMkCxbLLytY7mK0h8dRg@mail.gmail.com>
References: <1314021451-24808-1-git-send-email-penberg@kernel.org>
	<1314021451-24808-2-git-send-email-penberg@kernel.org>
	<CANeU7Q=xwx6TNA9PE_30=9i+KrCF0gRfXm2UPAXBpCg-7uncPg@mail.gmail.com>
	<4E56243C.1070906@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:44599 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751243Ab1HZDmy (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 25 Aug 2011 23:42:54 -0400
Received: by qwk3 with SMTP id 3so1749788qwk.19
        for <linux-sparse@vger.kernel.org>; Thu, 25 Aug 2011 20:42:54 -0700 (PDT)
In-Reply-To: <4E56243C.1070906@kernel.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pekka Enberg <penberg@kernel.org>
Cc: linux-sparse@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

On Thu, Aug 25, 2011 at 3:30 AM, Pekka Enberg <penberg@kernel.org> wrote:
> [PATCH 3/5] sparse: Fix __builtin_safe_p for pure and const functions

My fault. I have been travelling with limited Internet access.

Nothing serious wrong in this patch. This patch is much harder than the
other minor fix ups. So good progress on your sparse hacking.

There are two things I am considering and I am try some simple modifications,
which did not go very far yet.
1) It would be better not adding the attribute bits into the modifiers.
   We have been moving the attribute bits out of the modifiers.
   For very simple reason, it the modifier has very limited number of bits.
   We need better infrastructure support from storing attribute in general
   any way.

   On the other hand, there are a few other attribute bits are done it the
   same way so that is not your fault. Not adding to the modifier bits is
   a much bigger change.

2) The expand_symbol_call(), it return early if the pure bit is set.
    That might have unwanted side effect if the pure attribute is combine
    with the symbol that require expand. e.g. If some one apply pure attribute
    to symbol __builtin_const_p (I agree it is silly BTW), then
__buildin_const_p
    will not expand properly. I would move the return statement a few
lines below

Over all I am tempting to just apply it and fix the rest when we clean up
the attribute bits.

Actually, I just did that. Push to the chrisl repository, you can check if that
works for you or not.

> [PATCH 4/5] sparse, i386: Fix boolean bit size

I will reply in the original email.

Chris
