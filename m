From: Blue Swirl <blauwirbel@gmail.com>
Subject: [PATCH 1/2, RESEND] Ignore attribute __bounded__, used by OpenBSD
	headers.
Date: Sat, 1 Aug 2009 12:28:43 +0300
Message-ID: <f43fc5580908010228m75cc77eds2ecb23da51f031c1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:43934 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752629AbZHAJ3E (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 1 Aug 2009 05:29:04 -0400
Received: by fg-out-1718.google.com with SMTP id e12so210976fga.17
        for <linux-sparse@vger.kernel.org>; Sat, 01 Aug 2009 02:29:03 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

See also an obsolete version at
http://marc.info/?l=linux-sparse&m=113344255600417&w=2

Signed-off-by: Blue Swirl <blauwirbel@gmail.com>
---
 parse.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/parse.c b/parse.c
index e5ad867..613f439 100644
--- a/parse.c
+++ b/parse.c
@@ -530,6 +530,8 @@ static struct init_keyword {
 	{ "__hot__",	NS_KEYWORD,	.op = &ignore_attr_op },
 	{ "warning",	NS_KEYWORD,	.op = &ignore_attr_op },
 	{ "__warning__",	NS_KEYWORD,	.op = &ignore_attr_op },
+	{ "bounded",	NS_KEYWORD,	.op = &ignore_attr_op },
+	{ "__bounded__",	NS_KEYWORD,	.op = &ignore_attr_op },
 };

 void init_parser(int stream)
-- 
1.6.2.4
