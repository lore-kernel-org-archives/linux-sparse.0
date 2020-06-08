From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] pre-process: remove unneeded declaration of show_token_sequence()
Date: Tue,  9 Jun 2020 01:33:48 +0200
Message-ID: <20200608233348.66209-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731283AbgFHXdz (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 8 Jun 2020 19:33:55 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 467A0C08C5C2
        for <linux-sparse@vger.kernel.org>; Mon,  8 Jun 2020 16:33:54 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id q19so20278850eja.7
        for <linux-sparse@vger.kernel.org>; Mon, 08 Jun 2020 16:33:54 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Remove this declaration which follows the definition.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 pre-process.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/pre-process.c b/pre-process.c
index d96035e2339f..e6becf233eba 100644
--- a/pre-process.c
+++ b/pre-process.c
@@ -1585,8 +1585,6 @@ static int handle_ifndef(struct stream *stream, struct token **line, struct toke
 	return preprocessor_if(stream, token, arg);
 }
 
-static const char *show_token_sequence(struct token *token, int quote);
