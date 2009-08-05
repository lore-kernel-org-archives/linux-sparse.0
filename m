From: Blue Swirl <blauwirbel@gmail.com>
Subject: [PATCH 2/2] Define __LP64__ for x86_64 unless in 32 bit mode
Date: Wed, 5 Aug 2009 21:51:53 +0300
Message-ID: <f43fc5580908051151o2d3281acpfc1eabe81d93b6c2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.158]:8631 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751908AbZHESwM (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 5 Aug 2009 14:52:12 -0400
Received: by fg-out-1718.google.com with SMTP id e21so86267fga.17
        for <linux-sparse@vger.kernel.org>; Wed, 05 Aug 2009 11:52:13 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Signed-off-by: Blue Swirl <blauwirbel@gmail.com>
---
 cgcc |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/cgcc b/cgcc
index 59de967..1ddbcb0 100755
--- a/cgcc
+++ b/cgcc
@@ -265,7 +265,7 @@ sub add_specs {
 		&float_types (1, 1, 33, [24,8], [53,11], [113,15]) .
 		&define_size_t ("long unsigned int"));
     } elsif ($spec eq 'x86_64') {
-	return (' -Dx86_64=1 -D__x86_64=1 -D__x86_64__=1' .
+	return (' -Dx86_64=1 -D__x86_64=1 -D__x86_64__=1' . ($m32 ? '' : '
-D__LP64__=1') .
 		&integer_types (8, 16, 32, $m32 ? 32 : 64, 64, 128) .
 		&float_types (1, 1, 33, [24,8], [53,11], [113,15]) .
 		&define_size_t ($m32 ? "unsigned int" : "long unsigned int"));
-- 
1.6.2.4
