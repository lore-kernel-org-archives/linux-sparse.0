From: Christopher Li <sparse@chrisli.org>
Subject: Sparse 0.4.2-rc1
Date: Mon, 28 Sep 2009 00:33:36 -0700
Message-ID: <70318cbf0909280033p32c64e2fpbb563ac2b498fa8d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vw0-f203.google.com ([209.85.212.203]:59383 "EHLO
	mail-vw0-f203.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750900AbZI1Hdc (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 28 Sep 2009 03:33:32 -0400
Received: by vws41 with SMTP id 41so2696079vws.4
        for <linux-sparse@vger.kernel.org>; Mon, 28 Sep 2009 00:33:36 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

I just tagged the sparse git tree with v0.4.2-rc1.

It has been a long while since the last 0.4.1 release.
Al made a big overhaul of the parser to support better
type and attribute parsing. The rest of the changes are
mostly small improvements.

Please give it some test and report back any regression
you find.

Chris
