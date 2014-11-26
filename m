From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: sparse false positive in net/packet/af_packet.c
Date: Wed, 26 Nov 2014 15:52:07 +0200
Message-ID: <20141126135207.GA5480@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42163 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750967AbaKZNwL (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Wed, 26 Nov 2014 08:52:11 -0500
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@kernel.org>
Cc: linux-sparse@vger.kernel.org

sparse triggers warnings in net/packet/af_packet.c
in upstream Linux.
This is with sparse 0.5.0 in Fedora 20.
See below for more info.

I worked around this in source, but I think it's
a good idea to fix it in sparse as well, isn't it?

----- Forwarded message from "Michael S. Tsirkin" <mst@redhat.com> -----

Date: Mon, 24 Nov 2014 13:32:16 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Daniel Borkmann <dborkman@redhat.com>, Eric Dumazet <edumazet@google.com>, Atzm Watanabe
	<atzm@stratosphere.co.jp>, Hannes Frederic Sowa <hannes@stressinduktion.org>, Tom Herbert <therbert@google.com>, netdev@vger.kernel.org
Subject: [PATCH] af_packet: fix sparse warning
Message-ID: <1416828696-3989-1-git-send-email-mst@redhat.com>

af_packet produces lots of these:
	net/packet/af_packet.c:384:39: warning: incorrect type in return expression (different modifiers)
	net/packet/af_packet.c:384:39:    expected struct page [pure] *
	net/packet/af_packet.c:384:39:    got struct page *

this seems to be because sparse does not realize that _pure
refers to function, not the returned pointer.

Tweak code slightly to avoid the warning.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 net/packet/af_packet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index d4a877e..586229a 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -378,7 +378,7 @@ static void unregister_prot_hook(struct sock *sk, bool sync)
 		__unregister_prot_hook(sk, sync);
 }
 
-static inline __pure struct page *pgv_to_page(void *addr)
+static inline struct page * __pure pgv_to_page(void *addr)
 {
 	if (is_vmalloc_addr(addr))
 		return vmalloc_to_page(addr);
-- 
MST

----- End forwarded message -----
