From: Michael Stefaniuc <mstefani@redhat.com>
Subject: [PATCH] Ignore the ms_hook_prologue attribute.
Date: Mon, 22 Aug 2011 00:28:45 +0200
Message-ID: <20110821222845.GA20646@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:1027 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755968Ab1HUW2r (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Sun, 21 Aug 2011 18:28:47 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p7LMSlRD006401
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linux-sparse@vger.kernel.org>; Sun, 21 Aug 2011 18:28:47 -0400
Received: from brasov.str.redhat.com (brasov.str.redhat.com [10.32.0.1])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id p7LMSktw002833
	for <linux-sparse@vger.kernel.org>; Sun, 21 Aug 2011 18:28:46 -0400
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org


Signed-off-by: Michael Stefaniuc <mstefani@redhat.com>
---
 parse.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/parse.c b/parse.c
index 082c2c4..5435f6d 100644
--- a/parse.c
+++ b/parse.c
@@ -533,6 +533,8 @@ const char *ignored_attributes[] = {
 	"__model__",
 	"ms_abi",
 	"__ms_abi__",
+	"ms_hook_prologue",
+	"__ms_hook_prologue__",
 	"naked",
 	"__naked__",
 	"no_instrument_function",
-- 
1.7.6
