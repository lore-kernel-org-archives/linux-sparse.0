From: Sergey Lapin <slapinid@gmail.com>
Subject: building of call tree
Date: Fri, 2 Apr 2010 20:16:59 +0400
Message-ID: <k2u48239d391004020916w712535dala168de2a6d2b2bf7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:48322 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751591Ab0DBQRB (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 2 Apr 2010 12:17:01 -0400
Received: by wyb39 with SMTP id 39so974810wyb.19
        for <linux-sparse@vger.kernel.org>; Fri, 02 Apr 2010 09:16:59 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Hi, all!

I'd like to make call-tree builder using libsparse.
I need to build symbol-hierarchy and feed dot with it.
I use test-dissect.c as an example.

I understand how to extract the symbols and find if it is definition
or reference,
but I fail with scoping. I need to detect which function that
particular reference belongs to,
and how to detect if that reference is really a function.
sym->type isn't what I need, sym->ctype.base_type is used to print base type,
but I'd like to print type as is, and detect if that is a function a proper way.
Or is there any better way to get this information?

Thanks a lot,
S.
