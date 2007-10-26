From: Kovarththanan Rajaratnam <krj@rajaratnam.dk>
Subject: Re: Cygwin compile error:  No rule to make target `compat-Windows_NT.o',
 needed by `libsparse.a
Date: Fri, 26 Oct 2007 23:00:20 +0200
Message-ID: <fftkhh$aag$1@ger.gmane.org>
References: <zly6dqmj.fsf@blue.sea.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:50698 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752650AbXJZVBM (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Fri, 26 Oct 2007 17:01:12 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IlWIX-0004NI-7J
	for linux-sparse@vger.kernel.org; Fri, 26 Oct 2007 21:00:53 +0000
Received: from 0x5551d1e2.adsl.cybercity.dk ([85.81.209.226])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-sparse@vger.kernel.org>; Fri, 26 Oct 2007 21:00:53 +0000
Received: from krj by 0x5551d1e2.adsl.cybercity.dk with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-sparse@vger.kernel.org>; Fri, 26 Oct 2007 21:00:53 +0000
In-Reply-To: <zly6dqmj.fsf@blue.sea.net>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Hey,

Jari Aalto wrote:
> git checkout and "make" gives following results in Cygwin. There is no
> "INSTALL" file that would explain how the compilation should be
> arranged. Please advice.

You'll need to set OS=cygwin in makefile (line 3). That should do the trick.

-- 
Best Regards
Kovarththanan Rajaratnam
