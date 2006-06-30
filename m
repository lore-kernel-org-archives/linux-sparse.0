From: Josh Triplett <josht@vnet.ibm.com>
Subject: [PATCH] Ignore no_instrument_function attributes
Date: Thu, 29 Jun 2006 17:57:35 -0700
Message-ID: <1151629056.6507.41.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:44935 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S964838AbWF3A5i
	(ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Thu, 29 Jun 2006 20:57:38 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e32.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k5U0vbYK013706
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linux-sparse@vger.kernel.org>; Thu, 29 Jun 2006 20:57:37 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id k5U0vs3D139284
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-sparse@vger.kernel.org>; Thu, 29 Jun 2006 18:57:54 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k5U0vb7e016449
	for <linux-sparse@vger.kernel.org>; Thu, 29 Jun 2006 18:57:37 -0600
Received: from IBM-882E9B45D97.beaverton.ibm.com (IBM-882E9B45D97.beaverton.ibm.com [9.47.18.143])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k5U0valH016431
	for <linux-sparse@vger.kernel.org>; Thu, 29 Jun 2006 18:57:36 -0600
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Ignore the GCC attributes no_instrument_function and
__no_instrument_function__, used to turn off instrumentation for a particular
function when using GCC's -finstrument-functions option.

Signed-off-by: Josh Triplett <josh@freedesktop.org>

---

The Linux -rt tree uses this attribute, so sparse needs this fix in
order to run on the -rt tree.

 ident-list.h |    1 +
 parse.c      |    3 +++
 2 files changed, 4 insertions(+), 0 deletions(-)

9e44d55ae6c0371da2fae5bd8c9ca38860e7b221
diff --git a/ident-list.h b/ident-list.h
index 3051e56..798a9ac 100644
--- a/ident-list.h
+++ b/ident-list.h
@@ -53,6 +53,7 @@ IDENT(noinline);
 IDENT(deprecated);
 IDENT(__const); IDENT(__const__); IDENT(noreturn);
 IDENT(__noreturn__); IDENT(regparm); IDENT(weak); IDENT(__weak__);
+IDENT(__no_instrument_function__); IDENT(no_instrument_function);
 IDENT(__sentinel__); IDENT(sentinel);
 IDENT(alias); IDENT(pure); IDENT(always_inline);
 IDENT(syscall_linkage); IDENT(visibility);
diff --git a/parse.c b/parse.c
index 4339657..c536ec2 100644
--- a/parse.c
+++ b/parse.c
@@ -517,6 +517,9 @@ static const char * handle_attribute(str
 	if (attribute == &noreturn_ident ||
 	    attribute == &__noreturn___ident)
 		return NULL;
+	if (attribute == &no_instrument_function_ident ||
+	    attribute == &__no_instrument_function___ident)
+		return NULL;
 	if (attribute == &sentinel_ident ||
 	    attribute == &__sentinel___ident)
 		return NULL;
