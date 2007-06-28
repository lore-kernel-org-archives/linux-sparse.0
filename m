From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH 1/6] Bitfield without explicit sign should be a warning,
	not an error
Date: Thu, 28 Jun 2007 01:39:54 -0400
Message-ID: <20070628053954.30704.66440.stgit@dv.roinet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fencepost.gnu.org ([140.186.70.10]:38925 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756599AbXF1Fj4 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 28 Jun 2007 01:39:56 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <proski@gnu.org>)
	id 1I3mjT-0008Jw-Aq
	for linux-sparse@vger.kernel.org; Thu, 28 Jun 2007 01:39:55 -0400
Received: from localhost.localdomain ([127.0.0.1] helo=dv.roinet.com)
	by gnu.org with esmtp (Exim 4.66)
	(envelope-from <proski@gnu.org>)
	id 1I3mjS-0007zY-IK
	for linux-sparse@vger.kernel.org; Thu, 28 Jun 2007 01:39:54 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

The -Wdefault-bitfield-sign is supposed to control a warning, just like
other -W options.

Signed-off-by: Pavel Roskin <proski@gnu.org>
---

 parse.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/parse.c b/parse.c
index cb9f87a..ab3a096 100644
--- a/parse.c
+++ b/parse.c
@@ -1282,7 +1282,7 @@ static struct token *handle_bitfield(struct token *token, struct symbol *decl)
 		    !(bitfield_type->ctype.modifiers & MOD_EXPLICITLY_SIGNED) &&
 		    is_signed) {
 			// The sign of bitfields is unspecified by default.
-			sparse_error(token->pos, "dubious bitfield without explicit `signed' or `unsigned'");
+			warning(token->pos, "dubious bitfield without explicit `signed' or `unsigned'");
 		}
 	}
 	bitfield->bit_size = width;
