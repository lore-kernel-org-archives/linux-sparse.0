Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5783A1E60
	for <linux-sparse@vger.kernel.org>; Fri, 26 Dec 2025 14:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766759554; cv=none; b=MhfW5yaQh4H4whEcJPyzWn17M5sI9FL8HOqjepgx0kVfMOh+MWjagSd/GvNGHOLrpUFGkVwSCmRyM2Bnc3qIoNYtodAVQxZnojN9V0QfA7rWzpHMWV9cfe9DkIRHGgK7ClAS4bvMzC4z05l8aFsJz6n/LDI1ZFq14MNzhc7xaCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766759554; c=relaxed/simple;
	bh=up+hVMWRYYvy+N/A1IYunQ+LYBUw0f44Q7cgdjNfnKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=gS2lygzFQY1XNu9yZksKtLT8QxpCw8blcAusF73LyO/3N6YzQnJbRsiqKHky9R1JxGTb9ukM015w+kMcTt5yBx13g5KxG2JGC98JVBez09MA/eaMvh5+Kh+JFUoNL/mxO83ZAPSS31zNgekRHdyuZjI/4Env0wdAo7RWUszKpdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VmBgYDGD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VmBgYDGD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766759551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0t7GvnCvv9kTdLCS8dsuqrtQJa8DrjVSn4vpg4WaoSo=;
	b=VmBgYDGDDZdNo23zw9JcfCsJLF3g0aK4qknfTTS7Ma7p1k+My/9PT6r2eov8SuwHeMBF/B
	vHAYOqU2GDV6XxRBwth3e+yjUuD8nOyucu4Unv8o2SZJ1rITs0w3u3VINNCq78OHCJia2n
	s+03oUDLw264bOcav0aF010XVWjI2Xs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-452-mEaM-PRuN_GdxRiE6gKtoA-1; Fri,
 26 Dec 2025 09:32:28 -0500
X-MC-Unique: mEaM-PRuN_GdxRiE6gKtoA-1
X-Mimecast-MFC-AGG-ID: mEaM-PRuN_GdxRiE6gKtoA_1766759547
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 94EF01956046;
	Fri, 26 Dec 2025 14:32:27 +0000 (UTC)
Received: from fedora (unknown [10.45.224.10])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id B391219560A7;
	Fri, 26 Dec 2025 14:32:25 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 26 Dec 2025 15:32:27 +0100 (CET)
Date: Fri, 26 Dec 2025 15:32:24 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Chris Li <sparse@chrisli.org>, Luc Van Oostenryck <lucvoo@kernel.org>
Cc: Alexey Gladkov <legion@kernel.org>, linux-sparse@vger.kernel.org
Subject: [PATCH 2/2] sparse/semind: robustify parse_cmdline_add()
Message-ID: <aU6ceAt7RhlwGJ9-@redhat.com>
References: <aU6cXFyfwtD9GMYa@redhat.com>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aU6cXFyfwtD9GMYa@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dv0C9I4uhIL1Kxb6NQH0N2FnCs4phT58Uvg6KvqrPpU_1766759547
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

"semind add -ftabstop=8 ..." works as expected, but (for example)
"semind add --param=dissect-show-all-symbols ..." doesn't, this
arg is not passed to sparse_initialize().

Because in the latter case getopt_long() increments optind when it
sees --param=dissect-show-all-symbols. I have no idea if getopt_long()
is correct or not, but lets change parse_cmdline_add() so that it doesn't
depend on getopt_long()'s behaviour.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 semind.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/semind.c b/semind.c
index fa084e04..e9708444 100644
--- a/semind.c
+++ b/semind.c
@@ -298,7 +298,7 @@ static void parse_cmdline_add(int argc, char **argv)
 		{ "help", no_argument, NULL, 'h' },
 		{ NULL }
 	};
-	int c;
+	int parsed = optind, c;
 
 	opterr = 0;
 
@@ -315,6 +315,7 @@ static void parse_cmdline_add(int argc, char **argv)
 			case '?':
 				goto done;
 		}
+		parsed = optind;
 	}
 done:
 	if (optind == argc) {
@@ -327,9 +328,8 @@ done:
 	dissect_show_all_symbols = 1;
 
 	// step back since sparse_initialize will ignore argv[0].
-	optind--;
-
-	sparse_initialize(argc - optind, argv + optind, &semind_filelist);
+	parsed--;
+	sparse_initialize(argc - parsed, argv + parsed, &semind_filelist);
 }
 
 static void parse_cmdline_rm(int argc, char **argv)
-- 
2.52.0


