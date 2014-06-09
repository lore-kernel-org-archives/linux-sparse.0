From: Phil Carmody <phil@dovecot.fi>
Subject: [PATCH 0/3] catch non-sign-extended '~' brainos
Date: Mon,  9 Jun 2014 14:57:59 +0300
Message-ID: <1402315082-14102-1-git-send-email-phil@dovecot.fi>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from wursti.dovecot.fi ([87.106.245.223]:41384 "EHLO
	wursti.dovecot.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753037AbaFIMHz (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 9 Jun 2014 08:07:55 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: sparse@chrisli.org
Cc: linux-sparse@vger.kernel.org, phil@dovecot.fi

Chris, fellow sparsers,

Bitwise-not is often used to create masks. Unfortunately implicit conversions
to longer types may leave the recipient with fewer set bit than he expected,
if he started with an unsigned type. It's nice to warn that such constructs
are dubious.

The guts for the fix are in patch 2. I'm not sure this is the right location
for the fix, but the prior logical-not checks are quite closely related, so
I bundled them in together.

As an aside - while sniffing around that file, I came across a lot of helpers
who could have their pointer parameters made const - is there any interest in
some const clean-up, or is that unwanted comma-fudging?

Cheers,
Phil

