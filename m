Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E92393DEB
	for <linux-sparse@vger.kernel.org>; Sun, 10 May 2026 15:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778425611; cv=none; b=vB0oBqY3CIhxPHrETxZZhkXThG0LElP9UGo+n38ZgY/VeCB+mQXGrHTe6brzb9HwKUocPiYR3hmEKPgbxk9YXzIAqtyRhBKF1+bx1wfz1X1tX62BavQ2D/3H7FCDsRAkuyMFRJVXlfielyQW8cOSykWHbwAGZVmuFpoZS6pdR1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778425611; c=relaxed/simple;
	bh=Sbsa55LVp4aV6pBQOXRahEwgXZfRV7g/3CjlAOWep+c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JYVgW8cMM8G0P30xd9c9icR2TL93O8Ih4Xpb4YoaTmrQsXkvtsjHNTRo0Gu537RhJwFCM+U7CBXZQfT+QqfQw+q9znUjCxWN4sta42MG/qoKQqEPXfAVsg66VsWBmVyvazz/h1pqzIZw+9JpqA6UT+g4rhrGtA1GI3VxMVejAic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R/OuDhRZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R/OuDhRZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778425608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=8DgzgVjvrOr+QwU2BgEUEMCiAbn8YlsQ0PtbFHS4pL8=;
	b=R/OuDhRZdAi6JXKx8rEl4Wrvc3upUXPKCZG8sKCPROM5xL/tvmbjFZ5JUeDo8q4JTnDx/C
	Bb4E9RkWwZD6jhWleBMmyh7YnHUuPUnW38ghXi+eaPftVTIG8mLaVJHktsAfEi+RHfmCbQ
	U2SAtq3IQJLFmmvYAR4MsRmgd8YHnAo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-602-yk4fQmYUMluFDb0PrbUPvw-1; Sun,
 10 May 2026 11:06:43 -0400
X-MC-Unique: yk4fQmYUMluFDb0PrbUPvw-1
X-Mimecast-MFC-AGG-ID: yk4fQmYUMluFDb0PrbUPvw_1778425602
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7E9411800451;
	Sun, 10 May 2026 15:06:42 +0000 (UTC)
Received: from fedora (unknown [10.44.48.223])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id A507030001BE;
	Sun, 10 May 2026 15:06:40 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 10 May 2026 17:06:42 +0200 (CEST)
Date: Sun, 10 May 2026 17:06:38 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Chris Li <sparse@chrisli.org>, Luc Van Oostenryck <lucvoo@kernel.org>
Cc: Alexey Gladkov <legion@kernel.org>, linux-sparse@vger.kernel.org
Subject: [PATCH] sparse/dissect: fix parsing of array designated initializers
Message-ID: <agCe_rrtrOC-DNx2@redhat.com>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jZKu6DkWN-7Fvt4PevByscj0S4E0iZ3A9j6bIXw9dvQ_1778425602
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

dissect.c fails to parse nested designated initializers that contain array
indices. In this case do_initializer() is called recursively with type ==
EXPR_INDEX, this later calls do_expression(EXPR_IDENTIFIER).

Change the "while (m_expr->type == EXPR_IDENTIFIER)" loop to unwrap the
EXPR_INDEX expressions as well.

Minimal test-case:

	struct O {
		struct I { int mem; } ary[1];
	} v = {
		.ary[0].mem = 0,
	};

Before the patch:

    $ ./test-dissect TEST.c
    1:8                    def  s O
    2:16                   def  s I
    2:24                   def  m I.mem                              int
    2:31                   def  m O.ary                              struct I [1]
    3:3                    def  v v                                  struct O
    3:3                    -w-  v v                                  struct O
    4:10  v                -w-  m O.ary                              struct I [1]
    TEST.c:4:17: warning: bad expr->type: 25

the warning comes from do_expression(), 25 is EXPR_IDENTIFIER.
The usage of I.mem is not reported.

After the patch:

    $ ./test-dissect TEST.c
    1:8                    def  s O
    2:16                   def  s I
    2:24                   def  m I.mem                              int
    2:31                   def  m O.ary                              struct I [1]
    3:3                    def  v v                                  struct O
    3:3                    -w-  v v                                  struct O
    4:10  v                -w-  m O.ary                              struct I [1]
    4:17  v                -w-  m I.mem                              int

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 dissect.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/dissect.c b/dissect.c
index da1b63c8..796b6e4d 100644
--- a/dissect.c
+++ b/dissect.c
@@ -602,6 +602,11 @@ static struct symbol *do_initializer(struct symbol *type, struct expression *exp
 							lookup_member(m_type, m_expr->expr_ident, m_atop));
 					m_expr = m_expr->ident_expression;
 					m_atop = NULL;
+
+					while (m_expr->type == EXPR_INDEX) {
+						m_type = base_type(m_type);
+						m_expr = m_expr->idx_expression;
+					}
 				}
 
 				if (m_atop) {
-- 
2.52.0


