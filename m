Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58CA336EC5
	for <linux-sparse@vger.kernel.org>; Sun, 18 Jan 2026 14:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768748129; cv=none; b=JFU+iHAyCGwBJ+YcOBiB9MrhXWOeoV8xyrJtm2w5pA/yqIeRW9GiH7p4APMywyL/9JxkDIIErxldrpVxvpKu2d+FqmO7Fi4d/axs+K6G1rRnnJVqMfiG/5+rq+5b2EGw8fTkoGQlfeQA0s5dXpvLKKnylnWhPM7RyKttex03KBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768748129; c=relaxed/simple;
	bh=PPgO3ua7LAco0KusKdweD3iwmLbS0rdKeIng+kkM+JQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QsXNKMgQGDmB6fshVkt3kgrTxgU2913hhos83aXE6jhQOiz8He8dWvpM1/9eiP323COfrKQpXMcT4grv1ys6N2gJuGJDWBkO0HOpuHNXZuTfRSB75LDqS/jYo6XYkJUAVMbRsAOPMfjwQEnaTZQfmeEOzE91scABIM1vNgNEhWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aeGdmEH5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aeGdmEH5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768748126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=mV08S87IuGybUba1OC1HxvbTseSsy+8GdUmoMIReX7E=;
	b=aeGdmEH5icmoA0zUhlkZoHdbfoo6fS3Ul84U4wIEIPmq3RtbzdgpHA6MXnZbU6mCcxKWSK
	2a4Q6601Zar22flAJu4zA2wf07htuLVCYM9/4L82GFn9JGMzq4W3gM/Z7NdY+g/9K8Wb3c
	Ntbzhkv2+6dRX5mwqDS1PhuJpATZwCc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-192-owbvdiEnMoed-E6HNgJKqQ-1; Sun,
 18 Jan 2026 09:55:23 -0500
X-MC-Unique: owbvdiEnMoed-E6HNgJKqQ-1
X-Mimecast-MFC-AGG-ID: owbvdiEnMoed-E6HNgJKqQ_1768748122
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 670B919560B2;
	Sun, 18 Jan 2026 14:55:22 +0000 (UTC)
Received: from fedora (unknown [10.44.32.14])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 945781955F22;
	Sun, 18 Jan 2026 14:55:20 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 18 Jan 2026 15:55:21 +0100 (CET)
Date: Sun, 18 Jan 2026 15:55:19 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Chris Li <sparse@chrisli.org>, Luc Van Oostenryck <lucvoo@kernel.org>
Cc: Alexey Gladkov <legion@kernel.org>, linux-sparse@vger.kernel.org
Subject: [PATCH] sparse/pre-process: don't update next->pos in collect_arg()
Message-ID: <aWz0V_zQ47afKFJy@redhat.com>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: A2cwKJPgXroCGNbmhL5dddIUfxqHqeKjj02eInMl_h8_1768748122
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I don't quite understand why the expand() -> collect_arg() path
updates ->pos for each token in the input *list, but this breaks
dissect and thus semind.

Change collect_arg() to update next->pos only if "preprocess_only"
is true, the "if (preprocess_only)" block in sparse_tokenstream()
relies on the current behaviour.

Test-case:

	$ cat -n PP_POS.c
	     1	#define READ_ONCE(x) x
	     2	#define WRITE_ONCE(x, y) x = y
	     3
	     4	int R, W;
	     5
	     6	void func(void)
	     7	{
	     8	  WRITE_ONCE(
	     9	     W,
	    10	     READ_ONCE(R)
	    11	  );
	    12	}

	$ ./test-dissect PP_POS.c
	   4:5                    def   v R                                int
	   4:8                    def   v W                                int
	   6:6                    def   f func                             void ( ... )
	   8:3   func             -w-   v W                                int
	   8:3   func             -r-   v R                                int

The reported positions of the usage of R and W are wrong, and thus
./semind doesn't work:

	$ ./semind add PP_POS.c
	$ ./semind search -l PP_POS.c:10:16

With this patch:

	$ ./test-dissect PP_POS.c
	   4:5                    def   v R                                int
	   4:8                    def   v W                                int
	   6:6                    def   f func                             void ( ... )
	   9:6   func             -w-   v W                                int
	  10:16  func             -r-   v R                                int

	$ ./semind add PP_POS.c
	$ ./semind search -l PP_POS.c:10:16
	(def) PP_POS.c	4	5		int R, W;
	(-r-) PP_POS.c	10	16	func	READ_ONCE(R)

See also the changes in validation/parsing/attr-cleanup.c and
validation/sizeof-void.c, the updated positions look more correct.

Suggested-by: Chris Li <sparse@chrisli.org>
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 pre-process.c                     | 9 ++++++---
 validation/parsing/attr-cleanup.c | 2 +-
 validation/sizeof-void.c          | 2 +-
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/pre-process.c b/pre-process.c
index 3fb25082..5ab4810d 100644
--- a/pre-process.c
+++ b/pre-process.c
@@ -294,9 +294,12 @@ static struct token *collect_arg(struct token *prev, int vararg, struct position
 		} else if (match_op(next, ',') && !nesting && !vararg) {
 			break;
 		}
-		next->pos.stream = pos->stream;
-		next->pos.line = pos->line;
-		next->pos.pos = pos->pos;
+		/* See "if (preprocess_only)" in sparse_tokenstream() */
+		if (preprocess_only) {
+			next->pos.stream = pos->stream;
+			next->pos.line = pos->line;
+			next->pos.pos = pos->pos;
+		}
 		next->pos.newline = 0;
 		p = &next->next;
 	}
diff --git a/validation/parsing/attr-cleanup.c b/validation/parsing/attr-cleanup.c
index ac64649c..fa3cb1ca 100644
--- a/validation/parsing/attr-cleanup.c
+++ b/validation/parsing/attr-cleanup.c
@@ -24,7 +24,7 @@ int test(int n)
  * check-command: sparse -Wunknown-attribute $file
  *
  * check-error-start
-parsing/attr-cleanup.c:10:17: error: argument is not an identifier
+parsing/attr-cleanup.c:10:27: error: argument is not an identifier
 parsing/attr-cleanup.c:11:39: error: an argument is expected for attribute 'cleanup'
 parsing/attr-cleanup.c:12:40: error: an argument is expected for attribute 'cleanup'
 parsing/attr-cleanup.c:13:43: error: Expected ) after attribute's argument'
diff --git a/validation/sizeof-void.c b/validation/sizeof-void.c
index 0fd917a2..6792ff02 100644
--- a/validation/sizeof-void.c
+++ b/validation/sizeof-void.c
@@ -36,7 +36,7 @@ sizeof-void.c:16:14: warning: expression using sizeof(void)
 sizeof-void.c:17:14: warning: expression using sizeof(void)
 sizeof-void.c:18:14: warning: expression using sizeof(void)
 sizeof-void.c:19:14: warning: expression using sizeof(void)
-sizeof-void.c:20:14: warning: expression using sizeof(void)
+sizeof-void.c:20:27: warning: expression using sizeof(void)
 sizeof-void.c:21:14: warning: expression using sizeof(void)
 sizeof-void.c:22:14: warning: expression using sizeof(void)
 sizeof-void.c:23:14: warning: expression using sizeof(void)
-- 
2.52.0


