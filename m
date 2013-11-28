From: Franz Schrober <franzschrober@gmail.com>
Subject: [PATCHv2 0/5] sparse: Relicense from non-dfsg-free OSL 1.1 to MIT license
Date: Thu, 28 Nov 2013 11:16:17 +0100
Message-ID: <1385633782-775-1-git-send-email-franzschrober@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-bk0-f42.google.com ([209.85.214.42]:44902 "EHLO
	mail-bk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752667Ab3K1KQu (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 28 Nov 2013 05:16:50 -0500
Received: by mail-bk0-f42.google.com with SMTP id w11so3763022bkz.29
        for <linux-sparse@vger.kernel.org>; Thu, 28 Nov 2013 02:16:49 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: jw+debian@jameswestby.net, sparse@chrisli.org, franzschrober@gmail.com

Hi,

many different people (especially Dan Carpenter) worked quite hard to contact
all people with significant contributions. The two changes are the ones which
should change the license from the problematic OSL[1] to the more liberal MIT
license. The initial agreement was reached when Novafora (successor in
interest to Transmeta Corporation) accepted such a license [2]. The commit
provided by them is attached as "relicense.bundle" [3] and has to be 
unbundled+merged in the sparse repository before the following patches can be
applied.

The changes can also be pulled from

        git pull https://github.com/franzschrober/sparse.git master

Btw. when somebody has to ask me in the future about a license change of these
two patches: do whatever you want. They can be considered public domain.

The change of this patchset compared to the first version are:

 * Benjamin Herrenschmidt and Chris Wedgwood were added to the Acked-by list
   because they've also agreed to the license change
 * Reverts for James Westby's contributions were added because it seems that he
   is the only person not agreeing to the license change (he was not reachable
   over social media or any of his email accounts)
 * An alternative patch for the implicit casting bug found James Westby was
   added

[1] https://wiki.debian.org/DFSGLicenses#Open_Software_License_.28OSL.29_v1.1
[2] http://lwn.net/Articles/328560/
[3] http://marc.info/?l=linux-sparse&m=138548610116314&w=2

