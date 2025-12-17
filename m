Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D854B34E260
	for <linux-sparse@vger.kernel.org>; Wed, 17 Dec 2025 15:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765985166; cv=none; b=A009rUSRP80IMLPKwBqvRlcY/LjzwxLLONSRTVJCCzpJOkzNdpDSSBi2KZZdSJV9/EzQmg2uM8OjsRVTQE9+7jjLNCAFo1rCXdjos6YEOeZ5pNLUqF/W6I/Qmd8npPVMNIwSW9ZvwfHDzclMD3wqRtqV+Z5JYwHfyiiMBSHtkw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765985166; c=relaxed/simple;
	bh=GXTkHQtiqY6LnLZhU/siNxIEDWBS4i6gpgEilN8Rt3s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oddyYJsajjrQGcHFWUnyoUuP3y7EYSEbaMe7mq0kCxPNOr9jd/Q9GRbDwrw0yFZyxEIw83PDVE1o0Z23JzMDMVk7rjM4wJv5H/4GxBRqDS3ZAT0LmavAMfHdm9CUol0kL4llWmxJ8qqGtC4vqphr0/lOjYWelq7XXbIrmHpSU8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J+zr/mq+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J+zr/mq+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765985161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=hWRgAcl/6SyAFcsz3t7A6Mz+5YyYB30gNKPLXaAWN+g=;
	b=J+zr/mq+O7ot7qx/xKMBRy1E91RRQAG2FCmS/QKvc3FaaSm3XCxUk697o3bYDM+pIgtK3i
	kc508/T+SeHeqE+NsQRdNzBw8QpoEAZiVikPcsQt5Ru/oNIUnIzlIQCNRH/Y5AxP5lRFPL
	lgMuUnbw+B0PE7kPeeAVljc2ils8zBk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-474-TKdpYpoLN_iPqr6e54lQMQ-1; Wed,
 17 Dec 2025 10:25:40 -0500
X-MC-Unique: TKdpYpoLN_iPqr6e54lQMQ-1
X-Mimecast-MFC-AGG-ID: TKdpYpoLN_iPqr6e54lQMQ_1765985137
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D499A19F0971;
	Wed, 17 Dec 2025 15:17:48 +0000 (UTC)
Received: from fedora (unknown [10.44.33.39])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 26C561956056;
	Wed, 17 Dec 2025 15:17:46 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 17 Dec 2025 16:17:47 +0100 (CET)
Date: Wed, 17 Dec 2025 16:17:44 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Chris Li <sparse@chrisli.org>, Luc Van Oostenryck <lucvoo@kernel.org>
Cc: Alexey Gladkov <legion@kernel.org>, linux-sparse@vger.kernel.org
Subject: [PATCH] sparse/pre-process: introduce "dissect_mode" option to fix
 dissect/semind
Message-ID: <aULJmGi8yib_XH0P@redhat.com>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TW7PXfpyk6Ur39vYLVd-ujGuTNpkWhTkguHGxuKRWag_1765985137
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I don't quite understand why does expand() -> collect_arg() path
update ->pos for each token in the input *list, but this breaks
dissect and thus semind.

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

The reported positions of the usage of R and W are wrong,
and thus ./semind doesn't work:

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

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 dissect.c     | 1 +
 options.c     | 1 +
 options.h     | 1 +
 pre-process.c | 8 +++++---
 4 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/dissect.c b/dissect.c
index a6003afa..5fed8e22 100644
--- a/dissect.c
+++ b/dissect.c
@@ -714,6 +714,7 @@ end:
 
 void dissect(struct reporter *rep, struct string_list *filelist)
 {
+	dissect_mode = 1;
 	reporter = rep;
 
 	DO_LIST(filelist, file, do_file(file));
diff --git a/options.c b/options.c
index 6ee4d878..0f207e80 100644
--- a/options.c
+++ b/options.c
@@ -71,6 +71,7 @@ int dump_macro_defs = 0;
 int dump_macros_only = 0;
 
 int dissect_show_all_symbols = 0;
+int dissect_mode = 0;
 
 unsigned long fdump_ir;
 int fhosted = 1;
diff --git a/options.h b/options.h
index c2a9551a..b559254d 100644
--- a/options.h
+++ b/options.h
@@ -71,6 +71,7 @@ extern int dump_macro_defs;
 extern int dump_macros_only;
 
 extern int dissect_show_all_symbols;
+extern int dissect_mode;
 
 extern unsigned long fdump_ir;
 extern int fhosted;
diff --git a/pre-process.c b/pre-process.c
index 3fb25082..64445881 100644
--- a/pre-process.c
+++ b/pre-process.c
@@ -294,9 +294,11 @@ static struct token *collect_arg(struct token *prev, int vararg, struct position
 		} else if (match_op(next, ',') && !nesting && !vararg) {
 			break;
 		}
-		next->pos.stream = pos->stream;
-		next->pos.line = pos->line;
-		next->pos.pos = pos->pos;
+		if (!dissect_mode) {
+			next->pos.stream = pos->stream;
+			next->pos.line = pos->line;
+			next->pos.pos = pos->pos;
+		}
 		next->pos.newline = 0;
 		p = &next->next;
 	}
-- 
2.52.0


