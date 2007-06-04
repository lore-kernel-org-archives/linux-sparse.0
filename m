From: Michael Stefaniuc <mstefani@redhat.com>
Subject: sizeof() problem
Date: Mon, 04 Jun 2007 23:54:05 +0200
Message-ID: <466489FD.7010405@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:58946 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751446AbXFDVyK (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Mon, 4 Jun 2007 17:54:10 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l54Ls7uH013083
	for <linux-sparse@vger.kernel.org>; Mon, 4 Jun 2007 17:54:07 -0400
Received: from pobox.stuttgart.redhat.com (pobox.stuttgart.redhat.com [172.16.2.10])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l54Ls6ds007204
	for <linux-sparse@vger.kernel.org>; Mon, 4 Jun 2007 17:54:06 -0400
Received: from [10.32.4.22] (vpn-4-22.str.redhat.com [10.32.4.22])
	by pobox.stuttgart.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id l54Ls5HB003742
	for <linux-sparse@vger.kernel.org>; Mon, 4 Jun 2007 23:54:05 +0200
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Sparse Mailing-list <linux-sparse@vger.kernel.org>

Hello!

Running sparse on
	int i = sizeof((const char []) {'a','a','a',0});
gives
	zzz.c:1:9: error: cannot size expression

There are a few of those errors in Wine (char replaced with WCHAR).

bye
	michael
-- 
Michael Stefaniuc               Tel.: +49-711-96437-199
Sr. Network Engineer            Fax.: +49-711-96437-111
Red Hat GmbH                    Email: mstefani@redhat.com
Hauptstaetterstr. 58            http://www.redhat.de/
D-70178 Stuttgart
