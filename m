From: Sam Ravnborg <sam@ravnborg.org>
Subject: Warn for extern prototypes
Date: Wed, 30 Apr 2014 22:07:30 +0200
Message-ID: <20140430200730.GA11100@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from asavdk4.altibox.net ([109.247.116.15]:40367 "EHLO
	asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759308AbaD3UHe (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 30 Apr 2014 16:07:34 -0400
Received: from localhost (localhost [127.0.0.1])
	by asavdk4.altibox.net (Postfix) with ESMTP id 3E3FD80094
	for <linux-sparse@vger.kernel.org>; Wed, 30 Apr 2014 22:07:32 +0200 (CEST)
Received: from asavdk4.altibox.net ([127.0.0.1])
	by localhost (asavdk4.lysetele.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id vnQ2SgmRXzHu for <linux-sparse@vger.kernel.org>;
	Wed, 30 Apr 2014 22:07:32 +0200 (CEST)
Received: from ravnborg.org (unknown [188.228.89.252])
	(using TLSv1.2 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by asavdk4.altibox.net (Postfix) with ESMTPS id DF00A8008D
	for <linux-sparse@vger.kernel.org>; Wed, 30 Apr 2014 22:07:31 +0200 (CEST)
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: sparse <linux-sparse@vger.kernel.org>

Hi all.

Is it possible to get a warning when sparse encounter a
function prototype declared using "extern"?

So the following code:

extern void foo(void);
void bar(int x);

Would generate warnings because the declaration of foo()
uses extern.


I took a very short peek at evaluate.c - but decided to ask as maybe
there is already something that I overlooked or it is maybe trivial.

The rationale behind this is that at least in some areas of the kernel,
the use of "extern" for prototypes are no longer accepted.
A sparse warnings would be good to tell me all the cases I missed
in the conversion.

	Sam
