From: Alexey Zaytsev <alexey.zaytsev@gmail.com>
Subject: [PATCH 04/15] Replace the -specs cgcc option with -target
Date: Mon, 15 Dec 2008 03:26:19 +0300
Message-ID: <20081215002618.16107.37535.stgit@zaytsev.su>
References: <20081215000849.16107.74332.stgit@zaytsev.su>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-bw0-f21.google.com ([209.85.218.21]:48930 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750961AbYLOAYj (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 14 Dec 2008 19:24:39 -0500
Received: by bwz14 with SMTP id 14so1159553bwz.13
        for <linux-sparse@vger.kernel.org>; Sun, 14 Dec 2008 16:24:38 -0800 (PST)
In-Reply-To: <20081215000849.16107.74332.stgit@zaytsev.su>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@kernel.org>
Cc: Blue Swirl <blauwirbel@gmail.com>, Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org, David Given <dg@cowlark.com>

-spesc is just confusing, as gcc takes the same
option for something compeltely different.

Signed-off-by: Alexey Zaytsev <alexey.zaytsev@gmail.com>
---
 cgcc |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/cgcc b/cgcc
index 89adbed..31c219a 100755
--- a/cgcc
+++ b/cgcc
@@ -25,7 +25,7 @@ foreach (@ARGV) {
     $m64 = 1 if /^-m64$/;
     $gendeps = 1 if /^-M$/;
 
-    if (/^-specs=(.*)$/) {
+    if (/^-target=(.*)$/) {
 	$check .= &add_specs ($1);
 	$has_specs = 1;
 	next;

