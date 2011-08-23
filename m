From: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: (slightly) inconsistent code in evaluate.c:type_difference
Date: Wed, 24 Aug 2011 00:49:35 +0200
Message-ID: <20110823224935.GA1935@debian.debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.23]:44325 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753958Ab1HWWti (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 23 Aug 2011 18:49:38 -0400
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Hello, Sparse devs,

in evaluate.c, at lines 623 and 624, t1 and t2 are expected not to be
NULL, while a few lines later (630 and 638), they are checked to avoid
a NULL pointer dereference. That's at least a bit confusing.

Thanks,
	Jonathan Neusch=C3=A4fer
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
