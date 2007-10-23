From: Matthew Wilcox <matthew@wil.cx>
Subject: Bogus 'not declared' warning
Date: Tue, 23 Oct 2007 08:24:50 -0600
Message-ID: <20071023142450.GP27248@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from palinux.external.hp.com ([192.25.206.14]:41257 "EHLO
	mail.parisc-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751862AbXJWOYv (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 23 Oct 2007 10:24:51 -0400
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org


Seems to me that sparse ignores 'static' forward declarations, leading
to false warnings like this:

/home/willy/kernel/linux-2.6/drivers/scsi/sym53c8xx_2/sym_hipd.c:3786:5: warning: symbol 'sym_compute_residual' was not declared. Should it be static?

$ grep -n sym_compute_residual drivers/scsi/sym53c8xx_2/*
drivers/scsi/sym53c8xx_2/sym_hipd.c:61:static int sym_compute_residual(struct sym_hcb *np, struct sym_ccb *cp);
drivers/scsi/sym53c8xx_2/sym_hipd.c:3033:               cp->sv_resid = sym_compute_residual(np, cp);
drivers/scsi/sym53c8xx_2/sym_hipd.c:3786:int sym_compute_residual(struct sym_hcb *np, struct sym_ccb *cp)

This is a self-built sparse from commit
fa7d792f66cf02b86dd834d06b267ec66ddfe700.  The two commits since don't
appear relevant.

-- 
Intel are signing my paycheques ... these opinions are still mine
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
