From: Pekka Enberg <penberg@kernel.org>
Subject: OP_CALL and function pointers
Date: Fri, 18 Nov 2011 13:41:40 +0200
Message-ID: <CAOJsxLHB0V=RxPmhQiW=G-2VSno9tJm3GHE4YFsUybkQjHXNnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:48510 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755988Ab1KRLll (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 18 Nov 2011 06:41:41 -0500
Received: by vcbfk1 with SMTP id fk1so3025517vcb.19
        for <linux-sparse@vger.kernel.org>; Fri, 18 Nov 2011 03:41:40 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Sparse Mailing-list <linux-sparse@vger.kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jeff Garzik <jeff@garzik.org>, Christopher Li <sparse@chrisli.org>

Hello,

I'm implementing support for function pointer calls and I noticed that
->func->sym in 'strut instruction' is not SYM_NODE for function
pointers like it is for normal functions. Why is that?

LLVM expects us to use LLVMAddFunction() (which requires a name) and
pass the returned LLVMValueRef to LLVMBuildCall(). AFAICT, Clang uses
the function pointer symbol name as the function name.

                        Pekka
