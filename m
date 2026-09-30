Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D5F36B904;
	Wed, 30 Sep 2026 03:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790737696; cv=none; b=VTkt6qKUwQpF3e6b18Y5w4FRZCWvKQeoffvRDYiOYxNm+mh9FV63USM4aBcMTNN4Fg7LNMj/w+kDOueTwdcc7ukOSG+cNelv/0RjodphkfjilM0rw5ZnB+Rtjlgr2WGmlp5xm04MPvIrzT60s0LJcs8sw0uFv1P4sdhWbvN/pdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790737696; c=relaxed/simple;
	bh=Iv4wtlsTIdnAYiTSWW0vCXQOaUSDpeQO5E3NEpFBtvk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pi5TGe87+QtbmcUzySqwkJ26D2JDfreY7S7d5SN/AIwQpIwrjUmN1JF6N9I+EjjBPJC4+AbXHeNkNSyqkQX5k82meZId0A6ZDPuMdU21Lt0y1dDpclsYTTtJ7lN4WDaPFZkVdy0CFO4obyTXRPo4O9o+hW+QCPFNqG6SXxKbE9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=FfB5ZYAT; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="FfB5ZYAT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=tJ
	Vc+ek+/OL7mjlHCz2B1uUEAtE+OkNeX1hqUj5Ew8E=; b=FfB5ZYAT7yn+oTn2nA
	QhXGqPJvEIoeBzQbxVxTakVvh2UqunacViK8ahrZG2T+U2fJkiGUnC+oUj5DtOzH
	75qWlhVExPyJ0+bDeVBVCXfZT8FpCbof0tPWWrb56H7MeZ9KR2QwqIhp4w1VBazw
	Q6FdxIcvuVRSBQ18mozvZZhSI=
Received: from nans.company.local (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgDXf9b1fLxqY4WeCA--.38142S2;
	Wed, 30 Sep 2026 11:07:34 +0800 (CST)
From: nanshuaibo <nanshuaibo811@163.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Chris Li <sparse@chrisli.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sparse@vger.kernel.org,
	nanshuaibo <nanshuaibo811@163.com>
Subject: [PATCH] tracing: Make branch profiler counters atomic
Date: Wed, 30 Sep 2026 11:07:28 +0800
Message-ID: <20260930030728.1144418-1-nanshuaibo811@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgDXf9b1fLxqY4WeCA--.38142S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Xw1DJr1DKr15JFy3XFyxZrb_yoWxGw15pF
	W8JF97tF4rZFsIgrnF9w4rJw13G3yDta4SgrZrXwnxJF1qyr13KryIkFs0vrnYyryFkrya
	vryj93yUuwnFq3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pK-eYgUUUUU=
X-CM-SenderInfo: pqdq2xxxdlu0qyrrqiywtou0bp/xtbCwBcmYWq8fPeUKAAA3x

The branch profiler updates its static counters from arbitrary contexts. Concurrent updates can race and lose counts. KCSAN reports a data race between ftrace_likely_update() invocations.

Use relaxed compiler atomic operations for the counters. The profiler metadata is defined in compiler_types.h, before the kernel atomic API is available. The counters do not order accesses to other data.

Also use atomic loads when reading the counters for tracefs output and sorting, so readers do not race with atomic writers.

Tested on x86_64 QEMU/KVM with KCSAN and CONFIG_PROFILE_ANNOTATED_BRANCHES=y. The baseline reports the race in ftrace_likely_update(); it is not reported after this change.

Signed-off-by: nanshuaibo <nanshuaibo811@163.com>
---
 include/linux/compiler.h    | 14 ++++++++++--
 kernel/trace/trace_branch.c | 43 ++++++++++++++++++++++---------------
 2 files changed, 38 insertions(+), 19 deletions(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index cb2f6050b..7efbcd6aa 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -14,6 +14,16 @@
  */
 void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 			  int expect, int is_constant);
+
+/*
+ * Branch profiler data is defined in compiler_types.h, before the atomic API
+ * is available. These counters are independent statistics and do not order
+ * accesses to other data.
+ */
+#define ftrace_branch_counter_inc(counter) \
+	__atomic_fetch_add(&(counter), 1, __ATOMIC_RELAXED)
+#define ftrace_branch_counter_read(counter) \
+	__atomic_load_n(&(counter), __ATOMIC_RELAXED)
 #if defined(CONFIG_TRACE_BRANCH_PROFILING) \
     && !defined(DISABLE_BRANCH_PROFILING) && !defined(__CHECKER__)
 #define likely_notrace(x)	__builtin_expect(!!(x), 1)
@@ -66,8 +76,8 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 			.line = __LINE__,		\
 		};					\
 	(cond) ?					\
-		(__if_trace.miss_hit[1]++,1) :		\
-		(__if_trace.miss_hit[0]++,0);		\
+		(ftrace_branch_counter_inc(__if_trace.miss_hit[1]), 1) :\
+		(ftrace_branch_counter_inc(__if_trace.miss_hit[0]), 0);\
 })
 
 #endif /* CONFIG_PROFILE_ALL_BRANCHES */
diff --git a/kernel/trace/trace_branch.c b/kernel/trace/trace_branch.c
index d8e97ad79..36b61b5ed 100644
--- a/kernel/trace/trace_branch.c
+++ b/kernel/trace/trace_branch.c
@@ -73,7 +73,7 @@ probe_likely_condition(struct ftrace_likely_data *f, int val, int expect)
 
 	strscpy(entry->func, f->data.func);
 	strscpy(entry->file, p);
-	entry->constant = f->constant;
+	entry->constant = ftrace_branch_counter_read(f->constant);
 	entry->line = f->data.line;
 	entry->correct = val == expect;
 
@@ -202,7 +202,7 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 
 	/* A constant is always correct */
 	if (is_constant) {
-		f->constant++;
+		ftrace_branch_counter_inc(f->constant);
 		val = expect;
 	}
 	/*
@@ -213,11 +213,10 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 	 */
 	trace_likely_condition(f, val, expect);
 
-	/* FIXME: Make this atomic! */
 	if (val == expect)
-		f->data.correct++;
+		ftrace_branch_counter_inc(f->data.correct);
 	else
-		f->data.incorrect++;
+		ftrace_branch_counter_inc(f->data.incorrect);
 
 	user_access_restore(flags);
 }
@@ -239,13 +238,15 @@ static int annotated_branch_stat_headers(struct seq_file *m)
 
 static inline long get_incorrect_percent(const struct ftrace_branch_data *p)
 {
+	unsigned long correct = ftrace_branch_counter_read(p->correct);
+	unsigned long incorrect = ftrace_branch_counter_read(p->incorrect);
 	long percent;
 
-	if (p->correct) {
-		percent = p->incorrect * 100;
-		percent /= p->correct + p->incorrect;
+	if (correct) {
+		percent = incorrect * 100;
+		percent /= correct + incorrect;
 	} else
-		percent = p->incorrect ? 100 : -1;
+		percent = incorrect ? 100 : -1;
 
 	return percent;
 }
@@ -282,7 +283,8 @@ static void branch_stat_show(struct seq_file *m,
 static int branch_stat_show_normal(struct seq_file *m,
 				   struct ftrace_branch_data *p, const char *f)
 {
-	seq_printf(m, "%8lu %8lu ",  p->correct, p->incorrect);
+	seq_printf(m, "%8lu %8lu ", ftrace_branch_counter_read(p->correct),
+		   ftrace_branch_counter_read(p->incorrect));
 	branch_stat_show(m, p, f);
 	return 0;
 }
@@ -291,18 +293,21 @@ static int annotate_branch_stat_show(struct seq_file *m, void *v)
 {
 	struct ftrace_likely_data *p = v;
 	const char *f;
+	unsigned long constant;
 	int l;
 
 	f = branch_stat_process_file(&p->data);
+	constant = ftrace_branch_counter_read(p->constant);
 
-	if (!p->constant)
+	if (!constant)
 		return branch_stat_show_normal(m, &p->data, f);
 
-	l = snprintf(NULL, 0, "/%lu", p->constant);
+	l = snprintf(NULL, 0, "/%lu", constant);
 	l = l > 8 ? 0 : 8 - l;
 
 	seq_printf(m, "%8lu/%lu %*lu ",
-		   p->data.correct, p->constant, l, p->data.incorrect);
+		   ftrace_branch_counter_read(p->data.correct), constant, l,
+		   ftrace_branch_counter_read(p->data.incorrect));
 	branch_stat_show(m, &p->data, f);
 	return 0;
 }
@@ -329,6 +334,10 @@ static int annotated_branch_stat_cmp(const void *p1, const void *p2)
 {
 	const struct ftrace_branch_data *a = p1;
 	const struct ftrace_branch_data *b = p2;
+	unsigned long a_incorrect = ftrace_branch_counter_read(a->incorrect);
+	unsigned long b_incorrect = ftrace_branch_counter_read(b->incorrect);
+	unsigned long a_correct = ftrace_branch_counter_read(a->correct);
+	unsigned long b_correct = ftrace_branch_counter_read(b->correct);
 
 	long percent_a, percent_b;
 
@@ -340,9 +349,9 @@ static int annotated_branch_stat_cmp(const void *p1, const void *p2)
 	if (percent_a > percent_b)
 		return 1;
 
-	if (a->incorrect < b->incorrect)
+	if (a_incorrect < b_incorrect)
 		return -1;
-	if (a->incorrect > b->incorrect)
+	if (a_incorrect > b_incorrect)
 		return 1;
 
 	/*
@@ -350,9 +359,9 @@ static int annotated_branch_stat_cmp(const void *p1, const void *p2)
 	 * first, we continue that by showing best (correct)
 	 * cases last.
 	 */
-	if (a->correct > b->correct)
+	if (a_correct > b_correct)
 		return -1;
-	if (a->correct < b->correct)
+	if (a_correct < b_correct)
 		return 1;
 
 	return 0;
-- 
2.43.0

