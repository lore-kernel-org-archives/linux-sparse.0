From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] sparse: add 'alloc_align' to the ignored attributes
Date: Wed, 1 Jun 2016 15:30:30 +0100
Message-ID: <574EF186.5030505@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from avasout01.plus.net ([84.93.230.227]:49217 "EHLO
	avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757890AbcFAOiQ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 1 Jun 2016 10:38:16 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Chris,

Rui's recent patch prompted me to send this patch, which I have been
running with for a while.

ATB,
Ramsay Jones

 parse.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/parse.c b/parse.c
index b43d683..4b03192 100644
--- a/parse.c
+++ b/parse.c
@@ -504,6 +504,8 @@ static struct init_keyword {
 const char *ignored_attributes[] = {
 	"alias",
 	"__alias__",
+	"alloc_align",
+	"__alloc_align__",
 	"alloc_size",
 	"__alloc_size__",
 	"always_inline",
-- 
2.8.0
