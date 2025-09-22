Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D48730FC24
	for <linux-sparse@vger.kernel.org>; Mon, 22 Sep 2025 15:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758556465; cv=none; b=MWD94x3rRMTpUhTKVcQNtDGs+LAHW9Uc5XC4UNchrePnAuGheKK83jQ86PiFc9U2UFXkHUTIMNaGbDJqJZS3NUaE1E2LD0YIoaWMQwdGYvMf2WyeDuYZvi4bAxQW8lmH/th4+SiSIfy6Dtk7DQQKzWOKZogvA7QEsAtrZ1tsr0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758556465; c=relaxed/simple;
	bh=Cs9Qsap/BJC7bfCA6PcbtYOU1RN217HToMKrjgP2CcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=haDFyYj04OjajAJuXtk+zh4iN7vaJmZhJ8FlUSfIpN3kvllHJ2K7Y8+21QfdbAOiLZQlADUItrAHg28tEbffs+7quRV9UPE81NEtJu+Yn+4bQPgjQxzWQcAsUKmFphEtyDdTIN6XDKiGUi/YrQX0J3D3sJPwQS3v9jgm2/lqXrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LqCmvcuk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LqCmvcuk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B92DAC4CEF0;
	Mon, 22 Sep 2025 15:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758556464;
	bh=Cs9Qsap/BJC7bfCA6PcbtYOU1RN217HToMKrjgP2CcE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LqCmvcuk4Tmxqb8lXPraGXudxX1qjYs8p2XlkikheMkpULePQA6zw2bKU/Q2qqryX
	 /2xBKsRwiW980i0E8VcEEhc/H85JhrzSpXXo+6vWgQhas7DWSN2lPV6pvjGYDYWIw9
	 /lL1vTMMZ5Ku74nmBzXeAsAgwH3Okv7zbuQNOYkYYaOAARWbQ+xXkbDxtAKM/OpkUZ
	 mQq14HyxQg+8g0+3eoP5YprDPo1UerNHPCdGHvhDB7cXOEY5kqVIK/OTmxVoul2Aix
	 jHip8nlSpUJtRXV8SOAAAR8JssIpd84sJN7XiWhhEW3CnT0a6C5bNWqRFwDx4/eMor
	 OGENplYV+MhwA==
From: Vincent Mailhol <mailhol@kernel.org>
To: Chris Li <sparse@chrisli.org>,
	linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Vincent Mailhol <mailhol@kernel.org>
Subject: [PATCH] vadidation: add used-to-be-signed unit tests
Date: Tue, 23 Sep 2025 00:53:21 +0900
Message-ID: <20250922155415.3289196-1-mailhol@kernel.org>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <CACePvbWQVBNQAAreW-Mzkp8ircGtV+K=gNk39HmUC0TNDOBCwQ@mail.gmail.com>
References: <CACePvbWQVBNQAAreW-Mzkp8ircGtV+K=gNk39HmUC0TNDOBCwQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3349; i=mailhol@kernel.org; h=from:subject; bh=Cs9Qsap/BJC7bfCA6PcbtYOU1RN217HToMKrjgP2CcE=; b=owGbwMvMwCV2McXO4Xp97WbG02pJDBkXC46YHJOxcdzy8LVF2KIT815PPtSXuODezPeJk4KtJ 7iXXND801HKwiDGxSArpsiyrJyTW6Gj0Dvs0F9LmDmsTCBDGLg4BWAi+00Y/srxVrdFchfr3fwZ 8M4kjS98cvafuzsfmBz48uJK7oH6VCWGv1LvpxhUNN+duin1a+IF7nhl+388PJ472k0s91r+r7d M4wEA
X-Developer-Key: i=mailhol@kernel.org; a=openpgp; fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2
Content-Transfer-Encoding: 8bit

Add unit tests for the new used-to-be-signed check as introduced in [1]:

Results before applying [1]:

  $ ./test-suite used-to-be-signed.c
    TEST    used-to-be-signed (used-to-be-signed.c)
  error: actual error text does not match expected error text.
  error: see used-to-be-signed.c.error.* for further investigation.
  --- used-to-be-signed.c.error.expected	2025-09-23 00:50:07.079654644 +0900
  +++ used-to-be-signed.c.error.got	2025-09-23 00:50:07.073654719 +0900
  @@ -1,8 +0,0 @@
  -used-to-be-signed.c:8:19: warning: unsigned value that used to be signed checked against zero?
  -used-to-be-signed.c:6:33: signed value source
  -used-to-be-signed.c:11:17: warning: unsigned value that used to be signed checked against zero?
  -used-to-be-signed.c:6:33: signed value source
  -used-to-be-signed.c:14:20: warning: unsigned value that used to be signed checked against zero?
  -used-to-be-signed.c:6:33: signed value source
  -used-to-be-signed.c:17:18: warning: unsigned value that used to be signed checked against zero?
  -used-to-be-signed.c:6:33: signed value source
  error: FAIL: test 'used-to-be-signed.c' failed
  KO: out of 1 tests, 0 passed, 1 failed

...and after:

  $ ./test-suite used-to-be-signed.c
    TEST    used-to-be-signed (used-to-be-signed.c)
  OK: out of 1 tests, 1 passed, 0 failed

[1] Warn about "unsigned value that used to be signed against zero"
Link: https://lore.kernel.org/linux-sparse/20250921061337.3047616-1-mailhol@kernel.org/

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
Hi Chris,

Thanks for your guidance. I added more tests.

Because you asked me for my preference, I went for the single file.
But if you finally have a preference to split, tell me and I will
update.
---
 validation/used-to-be-signed.c | 49 ++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 validation/used-to-be-signed.c

diff --git a/validation/used-to-be-signed.c b/validation/used-to-be-signed.c
new file mode 100644
index 00000000..75eab7f3
--- /dev/null
+++ b/validation/used-to-be-signed.c
@@ -0,0 +1,49 @@
+void error(void);
+int check(void);
+
+static void positive_tests(unsigned int val)
+{
+	unsigned int ret = check();
+
+	if (ret < 0)
+		error();
+
+	if (0 > ret)
+		error();
+
+	if (ret >= 0)
+		/* Do stuff */;
+
+	if (0 <= ret)
+		/* Do stuff */;
+}
+
+static void negative_tests(unsigned int val)
+{
+	if (val < 0 || val > 42)
+		error();
+
+	if (0 > val || 42 < val)
+		error();
+
+	if (val >= 0 && val < 42)
+		/* Do stuff */;
+
+	if (0 <= val && 42 > val)
+		/* Do stuff */;
+}
+
+/*
+ * check-name: used-to-be-signed
+ *
+ * check-error-start
+used-to-be-signed.c:8:19: warning: unsigned value that used to be signed checked against zero?
+used-to-be-signed.c:6:33: signed value source
+used-to-be-signed.c:11:17: warning: unsigned value that used to be signed checked against zero?
+used-to-be-signed.c:6:33: signed value source
+used-to-be-signed.c:14:20: warning: unsigned value that used to be signed checked against zero?
+used-to-be-signed.c:6:33: signed value source
+used-to-be-signed.c:17:18: warning: unsigned value that used to be signed checked against zero?
+used-to-be-signed.c:6:33: signed value source
+ * check-error-end
+ */
-- 
2.49.1

