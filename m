From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
Subject: [PATCH 0/6] build: various updates
Date: Wed,  4 Oct 2017 15:25:59 +0200
Message-ID: <20171004132605.24734-1-uwe@kleine-koenig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from arcturus.kleine-koenig.org ([78.47.169.190]:54536 "EHLO
        arcturus.kleine-koenig.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752426AbdJDN0N (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 4 Oct 2017 09:26:13 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Hello,

this series motiviation is to support CPPFLAGS which is needed for
Debian packaging and includes the stuff I found while adding this.

Best regards
Uwe

Uwe Kleine-König (6):
  build: make PREFIX overwritable from the environment
  build: put comment about local.mk to the place where it is included
  build: drop BASIC_CFLAGS and ALL_CFLAGS
  build: drop -g from LDFLAGS
  build: pass standard make variables to compiler and linker
  build: replace *_EXTRA_OBJS by local assignments to LDFLAGS and
    LOADLIBES

 Makefile | 41 +++++++++++++++++++----------------------
 1 file changed, 19 insertions(+), 22 deletions(-)

-- 
2.14.2

