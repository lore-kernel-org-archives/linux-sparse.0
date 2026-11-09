Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794256415;
	b=h/PNMLkgmIhmG3kJW9Fxcu3vPHi9aL0lxXnIWUfUy0jmVvt1wrcBILTVBfLhNU9nNszo
	 HbPFXQj6CzxxoLKb6W46Q2a0PEYKkqCLT0rmGbO6zegx7FrYHFTW0YrYb0mhuTxYfaUWg
	 2QvemjlNpckcVHiOVx2kNBThzACVEqWDKdPX4/Uxdn/t8p6XpjV7ER3Y35lV6ZPKuVeP5
	 clk34KwchW+D2nqjIgZAIzgypK9rWehmQ2Thm+HMoFufsGVQD7eH480dDVXb7IcLRziLl
	 kaOLNybOZyRm64NC03Lf4IQdeZ8OzrpeSsbkWIvCQUcBPI0dk71fd+2TOidMQFlQbcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794256415;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=qJF+dc0eEz1IdrGLWWU9+VolsFxtxvCzPoeWxlSWqV8=;
	b=xS1LbOEPaVEXhJy+3mY+Gjp6kUsqvWyp+iJCg0dYG3LJR2+Q5rqjGBNAwU3Vkov1mob5
	 rpUllSA3lB8ClbjsII3gKwNGqFvwOfryGLsLSFvy9FGraHuYc0TIJmnBJzTnb9K5hSGY7
	 yeiWHGdQYT2pQMaSWhlRx/qp0oda/YJqMuMSV7uhBYd1xMgMgRr30qipUhTpIdwdbHIJp
	 4hhM84/YfI3PyFBg6iRNhQ3OJ0s8/T2uD9+yy3urGJzf4xHXfdeQkIBapTPkyZlBwa4DW
	 WgdtNeTW0z0gwwohCp+6aEPpzoW1UwaqMXNGJrOPGk3rVW40qp4ZEU39J227k5nMR5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=lkJEHDXe;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C33606A321
	for <linux-sparse@vger.kernel.org>; Mon,  9 Nov 2026 20:33:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40C33606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=lkJEHDXe
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jNhM21ZbLz1XLwXN;
	Mon,  9 Nov 2026 20:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1794256411; x=1796848412; bh=qJF+d
	c0eEz1IdrGLWWU9+VolsFxtxvCzPoeWxlSWqV8=; b=lkJEHDXehUHdmlYObNaEs
	mkfxpfVe2wjYKUyW0ntXd/eLv9EstljI2cGLN+q2TAx9IhXQIzdusbWajDt+zY7F
	JrpuZPJGQT0Bf0VWLmBHoSY4fAJJoDkFjgsTS7vkdICittjDss9e1F4htyv+YFNe
	dblyDU/oEbQ1PTijCA4KRqIvLmoYSs8UQNpSyynqfgaTWtvKWgaEQKeLZK77poQv
	x5LCvhDYKM9S176stBSkQUH6a4tuDoIY594oL5qG1cHTfBClFlF7NnL0UOsx+eEY
	dYRM/mThm3rxhiZOw0bHOhZa+FGDvyjrjVaHV/KmWB6Hjgfg5kmxzJR3iYipGvF3
	Q==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 2AUsvsXxxn3m; Mon,  9 Nov 2026 20:33:31 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jNhLv5z2Pz1XMFx7;
	Mon,  9 Nov 2026 20:33:27 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 16/73] memops, ssa: Walk parent insns in reverse and skip mixed-size SSA
Date: Mon,  9 Nov 2026 12:32:02 -0800
Message-ID: <20261109203259.362845-17-bvanassche@acm.org>
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

Fix dominated-store elimination and SSA promotion in memops.c and ssa.c:
- Walk parent basic block instructions in reverse order in
  kill_dominated_stores() so intervening loads or calls after a
  dominating store are visited before the store itself.
- Skip SSA promotion in ssa_convert_one_var() when loads or stores
  access the same variable with mixed sizes or non-zero offsets.
- Add regression test validation/optim/volatile-dse-and-cfg.c.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 memops.c                                |  4 +-
 ssa.c                                   |  6 +++
 validation/optim/volatile-dse-and-cfg.c | 53 +++++++++++++++++++++++++
 3 files changed, 61 insertions(+), 2 deletions(-)
 create mode 100644 validation/optim/volatile-dse-and-cfg.c

diff --git a/memops.c b/memops.c
index bfcdc1987a9d..4d2eac266b12 100644
--- a/memops.c
+++ b/memops.c
@@ -252,14 +252,14 @@ static void kill_dominated_stores(struct basic_bloc=
k *bb)
=20
 				if (bb_list_size(par->children) !=3D 1)
 					goto next_parent;
-				FOR_EACH_PTR(par->insns, dom) {
+				FOR_EACH_PTR_REVERSE(par->insns, dom) {
 					if (!dom->bb)
 						continue;
 					if (dom =3D=3D insn)
 						goto next_parent;
 					if (!try_to_kill_store(insn, dom, local))
 						goto next_parent;
-				} END_FOR_EACH_PTR(dom);
+				} END_FOR_EACH_PTR_REVERSE(dom);
 next_parent:
 				;
 			} END_FOR_EACH_PTR(par);
diff --git a/ssa.c b/ssa.c
index 4d3ead0c4ea2..0c9352c4958b 100644
--- a/ssa.c
+++ b/ssa.c
@@ -139,6 +139,7 @@ static void ssa_convert_one_var(struct entrypoint *ep=
, struct symbol *var)
 	bool local =3D true;
 	int nbr_stores =3D 0;
 	int nbr_uses   =3D 0;
+	bool same_size =3D true;
 	pseudo_t addr;
=20
 	/* Never used as a symbol? */
@@ -172,6 +173,8 @@ static void ssa_convert_one_var(struct entrypoint *ep=
, struct symbol *var)
 			}
 			/* fall through */
 		case OP_LOAD:
+			if (insn->size !=3D var->bit_size || insn->offset !=3D 0)
+				same_size =3D false;
 			if (local) {
 				if (!samebb)
 					samebb =3D bb;
@@ -197,6 +200,9 @@ static void ssa_convert_one_var(struct entrypoint *ep=
, struct symbol *var)
 		return;
 	}
=20
+	if (!same_size)
+		goto external_visibility;
+
 	idf_compute(ep, &idf, alpha);
 	FOR_EACH_PTR(idf, bb) {
 		struct instruction *node =3D insert_phi_node(bb, var);
diff --git a/validation/optim/volatile-dse-and-cfg.c b/validation/optim/v=
olatile-dse-and-cfg.c
new file mode 100644
index 000000000000..8b0c2d21d539
--- /dev/null
+++ b/validation/optim/volatile-dse-and-cfg.c
@@ -0,0 +1,53 @@
+static void test_volatile_stores(volatile int *p)
+{
+	*p =3D 1;
+	*p =3D 2;
+}
+
+static void test_asm_mem(int *p)
+{
+	int x =3D 42;
+	asm volatile("" : : "m"(x));
+}
+
+struct mixed_bf {
+	int a:20;
+	int b:20;
+};
+
+static struct mixed_bf ssa_mixed_load(int c, struct mixed_bf x, struct m=
ixed_bf y, int *out)
+{
+	struct mixed_bf s;
+	if (c)
+		s =3D x;
+	else
+		s =3D y;
+	struct mixed_bf copy =3D s;
+	*out =3D s.a;
+	return copy;
+}
+
+extern int glob;
+extern void ext_call(void);
+
+static void dom_store_order(int c)
+{
+	glob =3D 1;
+	if (c)
+		ext_call();
+	else
+		glob =3D 3;
+	glob =3D 2;
+}
+
+/*
+ * check-name: volatile-dse-and-cfg
+ * check-command: test-linearize -Wno-decl $file
+ *
+ * check-output-ignore
+ * check-output-excludes: VOID
+ * check-output-contains: store\\.32.*\\$1 -> 0\\[%arg1\\]
+ * check-output-contains: store\\.32.*\\$2 -> 0\\[%arg1\\]
+ * check-output-contains: store\\.32.*\\$42 -> 0\\[x\\]
+ * check-output-contains: store\\.32.*\\$1 -> 0\\[glob\\]
+ */
