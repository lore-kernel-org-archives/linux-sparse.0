Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794256415;
	b=zHfpO62jIYQOjHamIheC+PavmVjii1GmOFqw1YEDbdETWINILh1c24r8/rTiQBvGZV29
	 tsxTYvKJnFC8JBCNfN7O5YsfEl2flo0H1MKaOY+rwfasvepf2pWUA0WiYwswLJRGeta/I
	 /mf108vwT2z7Q6+fIk0gwA/EnTUVmJUplFlmZ3TV4e+ddcxcX5PTf3//eW9U3PYX3o3Vq
	 q+4LmOk2jKoQC1uTT/ARCHV0dEHKRdHP/JBRFkz8n2z53LAD9tuChp8ZgpS9bJqKZBdq6
	 a5sHTVpyyVQ7fChpXl5ojOnQheA+pyPPBUU0D0LiVAL1w9lLWCJIaLwFguvBMA2skdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794256415;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=oCQsfL2DlHlEpsXELqu+yvdIM8VtyIged0jThFqMLX8=;
	b=woXRGuwZdOIZBkJQlXuYnUp39coTf1GGv5nrZhEQNsVGvhvZq753p4uG3Ru9nGlIhmh2
	 SZiJdRqp4v7ytDa0vnoaOFgls1e0IAEx010K5iSLZ7JTABHnqlYgZ5EHYXbsxGxBi0vYK
	 95YykLpJONVgIz9WZo0b6T1JPfaNfE7InFXzmOa0tMfGzVxChbjIgPZYjMC4enPyzma/S
	 P4cHp2DvjX5EKr9xqBMg6ahDKrNuwoIefvsTuEZGF9OZOzuEnkxvVemY2oyCy1JSLu1YL
	 IflHIoClKXn5bDy5VHG/YuC4EdBf7axVuDrIb6VxGVDaQmWjvMBxUFwKSthgYjMpWOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=FLlXg3RY;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB722606A31C
	for <linux-sparse@vger.kernel.org>; Mon,  9 Nov 2026 20:33:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB722606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=FLlXg3RY
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jNhM21KPJz1XM6JF;
	Mon,  9 Nov 2026 20:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1794256412; x=1796848413; bh=oCQsf
	L2DlHlEpsXELqu+yvdIM8VtyIged0jThFqMLX8=; b=FLlXg3RYP5ADqnjVQUmmZ
	REYWirfsVmnCemXjNAUthBRU4aOgARI9Gb/SPZGFe5fq1pMHIfSn4tMWtPWOg4jG
	jM3qEFufoqAE+jNuotdUST+zDKqmcf2iIyQ0Sf/tvRDMHMo8wpbFHM6uRzlsNxKi
	ajAB6UTd/Wnt7sMIzbvNeRUlVI2Cv2sJYcLTX0k2hVAAjNbcFhW0CQjmjtOGxK52
	DbhoXlN9CNCIELXn7N+S3XtOqfHH0cU+sSj6uUFU7I8XkGEBj/w7z8I3SLt14wCc
	yJk8K3KoW9mJVWV+z/ayv/tYPxApXbxjZDrLIOdepOVqZ5ATl4NmY3s4Q+sNnLzl
	w==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id nSsxfWqkbIQf; Mon,  9 Nov 2026 20:33:32 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jNhLw27RKz1XLwXN;
	Mon,  9 Nov 2026 20:33:28 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 18/73] sparse: Gate context failure warning on Wcontext and catch underflow
Date: Mon,  9 Nov 2026 12:32:04 -0800
Message-ID: <20261109203259.362845-19-bvanassche@acm.org>
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
In-Reply-To: <20261109203259.362845-1-bvanassche@acm.org>
References: <20261109203259.362845-1-bvanassche@acm.org>
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Post: <mailto:linux-sparse@vger.kernel.org>
List-Help: <mailto:linux-sparse+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sparse+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Gate "context check failure" diagnostics on Wcontext in
context_increase() and return early as soon as entry + sum drops below
zero so an unexpected unlock followed by a lock in the same basic block
still triggers a context imbalance warning.

Add regression test validation/context-fixes.c.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 sparse.c                   |  5 ++++-
 validation/context-fixes.c | 41 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 1 deletion(-)
 create mode 100644 validation/context-fixes.c

diff --git a/sparse.c b/sparse.c
index e7cc6f55e503..883a5edec5b1 100644
--- a/sparse.c
+++ b/sparse.c
@@ -59,10 +59,13 @@ static int context_increase(struct basic_block *bb, i=
nt entry)
 					continue;
 			} else if (current >=3D val)
 				continue;
-			warning(insn->pos, "context check failure");
+			if (Wcontext)
+				warning(insn->pos, "context check failure");
 			continue;
 		}
 		sum +=3D val;
+		if (entry + sum < 0)
+			return sum;
 	} END_FOR_EACH_PTR(insn);
 	return sum;
 }
diff --git a/validation/context-fixes.c b/validation/context-fixes.c
new file mode 100644
index 000000000000..ab6c354cacea
--- /dev/null
+++ b/validation/context-fixes.c
@@ -0,0 +1,41 @@
+static void lock(void) __attribute__((context(0, 1)))
+{
+	__context__(1);
+}
+
+static void unlock(void) __attribute__((context(1, 0)))
+{
+	__context__(-1);
+}
+
+/* 1. Context attribute before pointer return type */
+extern __attribute__((context(0, 1))) void *lock_ret_ptr(void);
+
+static void good_ptr_lock(void)
+{
+	void *p =3D lock_ret_ptr();
+	(void)p;
+	unlock();
+}
+
+static void warn_ptr_lock(void)
+{
+	lock_ret_ptr();
+}
+
+/* 2. Unlock followed by lock in same basic block must warn */
+static void warn_unlock_then_lock(void)
+{
+	unlock();
+	lock();
+}
+
+/*
+ * check-name: context-fixes
+ * check-command: sparse -Wcontext $file
+ *
+ * check-error-start
+context-fixes.c:21:13: warning: context imbalance in 'warn_ptr_lock' - w=
rong count at exit
+context-fixes.c:27:13: warning: context imbalance in 'warn_unlock_then_l=
ock' - unexpected unlock
+ * check-error-end
+ */
