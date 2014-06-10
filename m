From: Phil Carmody <phil@dovecot.fi>
Subject: [PATCHv2 0/3] catch non-sign-extended '~' brainos
Date: Tue, 10 Jun 2014 10:54:04 +0300
Message-ID: <1402386847-23477-1-git-send-email-phil@dovecot.fi>
References: <1402315082-14102-1-git-send-email-phil@dovecot.fi>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from wursti.dovecot.fi ([87.106.245.223]:39511 "EHLO
	wursti.dovecot.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751462AbaFJHxv (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 10 Jun 2014 03:53:51 -0400
In-Reply-To: <1402315082-14102-1-git-send-email-phil@dovecot.fi>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: sparse@chrisli.org
Cc: josh@joshtriplett.org, linux-sparse@vger.kernel.org, phil@dovecot.fi

Bitwise-not is often used to create masks. Unfortunately implicit conversions
to longer types may leave the recipient with fewer set bit than he expected,
if he started with an unsigned type. It's nice to warn that such constructs
are dubious.

v2: cleaned up as per recommendations from Josh Triplett.

