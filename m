From: Jeff Garzik <jeff@garzik.org>
Subject: sparse as a compiler front-end
Date: Sat, 11 Nov 2006 16:54:08 -0500
Message-ID: <45564680.8090806@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:38325 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1947311AbWKKVyN (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 11 Nov 2006 16:54:13 -0500
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Matt Domsch <Matt_Domsch@dell.com>
Cc: linux-sparse@vger.kernel.org, Josh Triplett <josh@freedesktop.org>

I see that sparse made it into Fedora Extras, so that 'yum install' 
automatically pulls it down for me.  Yay!  Thanks, Matt.

Can libsparse.a and necessary includes be packaged as well?

I have wild ambitions of rewriting compile-i386.c (my int-only x86 
pseudo-compiler) using the new basic block stuff, into a proper [if very 
very basic] C99 compiler.

	Jeff
