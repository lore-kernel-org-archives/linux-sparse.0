From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [GIT PULL] llvm fixes
Date: Fri, 17 Nov 2017 10:51:49 +0100
Message-ID: <20171117095147.a4v4alrcr77rafut@ltop.local>
References: <20170918095135.12066-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:46709 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752119AbdKQJvt (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 17 Nov 2017 04:51:49 -0500
Received: by mail-wm0-f44.google.com with SMTP id z3so5207061wme.5
        for <linux-sparse@vger.kernel.org>; Fri, 17 Nov 2017 01:51:49 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20170918095135.12066-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Dibyendu Majumdar <mobile@majumdar.org.uk>

FWIW, I've now pushed this to my dev tree at:
	git://github.com/lucvoo/sparse.git master

with the two patches related to OP_PUSH removed and
replaced by something with minimal impact and directly
storing the type of the arguments into the OP_CALL
instructions.

-- Luc Van Oostenryck 
