From: Chris Lattner <sabre@nondot.org>
Subject: New LLVM C front-end
Date: Fri, 13 Jul 2007 09:54:25 -0700 (PDT)
Message-ID: <Pine.LNX.4.62.0707130940060.26974@nondot.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from 70-91-206-189-BusName-SFBA.hfc.comcastbusiness.net ([70.91.206.189]:60544
	"EHLO nondot.org" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1752992AbXGMQJS (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 13 Jul 2007 12:09:18 -0400
Received: from localhost (localhost [127.0.0.1])
	by nondot.org (Postfix) with ESMTP id A2BA7964181
	for <linux-sparse@vger.kernel.org>; Fri, 13 Jul 2007 09:54:25 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org


Hi Sparsers,

We've recently been building a new C front-end for LLVM from scratch. 
Information about it is here:
http://lists.cs.uiuc.edu/pipermail/llvmdev/2007-July/009817.html

The work is still somewhat early (for example, though the parser is quite 
far along, we don't emit all warnings and errors that we should, and the 
code generator doesn't support many constructs yet), but we're pursuing it 
aggressively.  Over the next couple years, we hope to grow it out to 
include full C++ support as well as C.

Compared to sparse, some goals are similiar: provide an extremely fast C 
parser (including preprocessor, type checker, etc) which can be reused by 
many different clients (static analysis, refactoring, indexing, etc).

Others goal are different.  In contrast to sparse, we aim (in the short 
term) to provide strict ISO standards compliance, support for a full suite 
of GCC extensions (whether they are well considered or not :-/ ), and code 
generation support through LLVM.  Also, the code is BSD licensed.

This email is only intended as an FYI, so I'll keep it short.  If you have 
any questions, please ask on the cfe-dev list:
http://lists.cs.uiuc.edu/mailman/listinfo/cfe-dev

-Chris

-- 
http://nondot.org/sabre/
http://llvm.org/
