Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779542116E0
	for <linux-sparse@vger.kernel.org>; Tue, 28 Oct 2025 13:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761658337; cv=none; b=eXenQktFtx5U+PQVNvcbun0jFOTkKRwuiuASgycNnn0dMxgMYJTkbbdORiWfpuLh/W+8htYBAhYhH7Pc1uCzGYjJhZronnshOmrevLAfrywqTjsGITfeHmyRvmvofsY2otomDHNR7nx+GDA7KHXCe2WDjdVVYs1YD19H4hOPqro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761658337; c=relaxed/simple;
	bh=km5o7vOB1VDedL0cRnYgEM/+ABakR85Cj1uqz+9CjxM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YwjonCfYsM/kXZ7/uv98/oSxAyVW3BrHEU65yHT4/LY/lDI1kNSHt7MmJHTHOnk8q7wgftg4a1hu6TysTNbY8WzY0RPN9Aopy6PIcYXcugTt19yPmW7zm2jLLvTYinwbErxjgBTEBqeBplvyIuXFgYYHuLdfp35b7Br6VePk1d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eUrE5TQB; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eUrE5TQB"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4710683a644so50337095e9.0
        for <linux-sparse@vger.kernel.org>; Tue, 28 Oct 2025 06:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761658333; x=1762263133; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sDbhm4hMBPA//zbQdBfUyYQEK1bpEK9nxO1Rs/g1OdE=;
        b=eUrE5TQBcuQxznhZtvqs1IkNl5Ge44OsYHtltdBxE0WyYgeCrRX1jJnNDyPqDHamIo
         NmfnG/RAJz8GUo7PMU3toUtEANM4BWeQ+8XZgW2I87Jpx4FNi81gad4lK1IObxldLxIC
         Yz1UVEeK15DpfMiEsuS7z3uU+NLtm9GF0NtXAfeePSAX8OJfosDb6d8A6m3B/aSfUv22
         6NrV/5ceTSaBX/t+jvjmyhpj2khLnVqHcCtsAI4QLysvQy0NRCC+ZPJ+2Mre9FYNCHJL
         a9fV90mhB6A4vuW0Lp8hS3YTQzlHU0bcXPUcyk5mklDDT0xM2H+0zsEjTaCLYikEDhMu
         cgRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761658333; x=1762263133;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sDbhm4hMBPA//zbQdBfUyYQEK1bpEK9nxO1Rs/g1OdE=;
        b=geM+/iaNFUT1DP7D3jTHZ63RHREboHltTDY22yiFA0uLYKBALGGWhrOyOZRjXvBM0H
         601RL/ypfcJM5gbN2/8AtMFBbVIweRe3q3ytzlFi3GYjBwHTxLQKapJ9J6EM5jhqJvn3
         p6XRmZvvo0W0YW7+86HcVGvGYiRytewMwOfMAEnL243CAraPqqDL6plG9t7YZXjxKDG8
         A3w0O0qyDRx220u7xdaPxMk9F6EbZ1bEfW219oY6rOKbqwoS/RTdsA1C+e/dx5/1d8zQ
         EaQFz46anGH1F36rYhqus/0u0yYoIgzA88twT7pbyZ8sIWPXVRxjaE4d3VRhHyJTkCJf
         362g==
X-Gm-Message-State: AOJu0YyYxZ4NYtUte5WY1LpXC1i9xosBd/vXD8f/1tZZ2h6ED9erwHS/
	RHI3eFoxPY5r6cF4e0FYVEkmnh4Gt9XPVlBHl07Ul6uU3GGMKNIyLIJDvLMJHbaDfAk=
X-Gm-Gg: ASbGncvanuZJM743Q98SYkv/JgesaNTDFmo+RLMlWJJvV22FnRgjT7JK8dWZvdCE1i9
	r7kcovsCZm655y5sqPJ7KG+smo77iIsnyGnpS0cOsRqbSM2DXhqd9DOTjFq9FXzupaQ8CHP4WgQ
	Q2LvyliYOeqgjQ9s/V8ygaJbv9sfv2njhFFgPKUJEwAgf0xRW2dZUxh4tOlKfMKD/sOo/5nZEwt
	zQk+ZUNU494Yuc8kyw8CmdzquQYIQAC2FKUMbxuF5qAjCLEd8AfFcoLUIX+KiIyCaB0D2QG+6cq
	hdc75aR9oGKMAP1hHlVLeTBSk+P55ueDwzugZ3rbXfgmFsR3P68R7UpPjTQqj9ULaRvJxA6MhxV
	cR19858TvA9O/JcZ0X65xY736iFFkdTl+vkZe6Syxt/2XA6R3BRrKch4sVQzueyYPd68gEUe0Ph
	RAAEUZHGlolrcXBs1E
X-Google-Smtp-Source: AGHT+IFzY95GbWlmBGL7e7zcBlCLbWG8NoAlqOrzl7/zew5onBDCzlRenmUtpB4TaHpUCIIvdWo8Ew==
X-Received: by 2002:a05:600c:46d3:b0:45f:29eb:2148 with SMTP id 5b1f17b1804b1-4771a46941fmr20999875e9.7.1761658332594;
        Tue, 28 Oct 2025 06:32:12 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-475dd4a6043sm196596035e9.12.2025.10.28.06.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 06:32:12 -0700 (PDT)
Date: Tue, 28 Oct 2025 16:32:08 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Chris Li <sparse@chrisli.org>, Uros Bizjak <ubizjak@gmail.com>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>
Subject: [PATCH] validation: add check for typeof() and address spaces
Message-ID: <aQDF2Ila2-LNmllC@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The typeof() key word should preserve the address space and
typeof_unqual() should not.  Add a check to verify this works as
expected.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 validation/typeof-as.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 validation/typeof-as.c

diff --git a/validation/typeof-as.c b/validation/typeof-as.c
new file mode 100644
index 000000000000..563685281d92
--- /dev/null
+++ b/validation/typeof-as.c
@@ -0,0 +1,32 @@
+#define __seg_gs		__attribute__((address_space(__seg_gs)))
+static int __seg_gs m;
+
+static int __seg_gs bad_manual (void)
+{
+	return (*(int *)&m);
+}
+
+static int __seg_gs good_manual (void)
+{
+	return (*(int __seg_gs *)&m);
+}
+
+static int bad_typeof (void)
+{
+	return (*(typeof_unqual(m) *)&m);
+}
+
+static int __seg_gs good_typeof (void)
+{
+	return (*(volatile typeof(m) *)&m);
+}
+
+/*
+ * check-name: typeof address space
+ * check-command: ./sparse typeof-as.c
+ *
+ * check-error-start
+typeof-as.c:6:19: warning: cast removes address space '__seg_gs' of expression
+typeof-as.c:16:19: warning: cast removes address space '__seg_gs' of expression
+ * check-error-end
+ */
-- 
2.51.0

