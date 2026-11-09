Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794256418;
	b=1B3GOCfwFzLJn9NfgfWycjoA/cWlpIBNz00jgNcBL4qWk8C6EYSuJaI4pWAsI0UfL+Ly
	 D/cuLA8HV6wzzF5TudgOghArqdVwgUFjO0qBUwlJ7udCmyU+UjY1V8W58jkM1TP1cfA/v
	 DuMeVT7Js1MZGaDG8OWOEHpyfP/lSIjkjLiNU9T+KSpsBFD1hRqWp2U6hg/gM8485SqdL
	 O+ruCJ/l9fvTZhOgqQZw7k0riU6dcMnhBc6AqBy781e7D8Sdc2ghMJtai7mBAQ088tDpP
	 U7GjOwr8naoplqqlLQN4IWCYgH0A3wLf5EJKTeViFzZgEzaLr3r62bYfs9PwuMh8uNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794256418;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=MEJWSY/WIrHmOt8+p9vSlvw+Vct9t3m6H9LLvn5TkqU=;
	b=WPVAajNqV4EvPDORTHU+uclGVjbKrlQzI9fpktlcFgChblojN9MLuKObkUaGuI0L8h5k
	 Grnk8nMSXv19PxIbQIOwZ99ZInoTvwpCkCihaEYiiZS5H2tmOaQhXIjqgoNaudttFia9U
	 V7bFuNiSBNPlFz7Ex4V8uR0az7gXAV+fr5Z2o9snbuaU9JdMo+iE5oFUHkitz5Sgcek74
	 sNCKzB541BCNwNEkVB7i5VC2VIOrEsO4ZogkxtQDcYWJkRoYFiA2vfS0aHiQpTFDMh1i/
	 8QI2Lbq6uqsKbI/N5qdOBmPOehrF1yzsecyu2gKU9ZsBY4IZ+h1EzbDhz2MPXHr1JuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=eVSYsiJM;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CA9606A32A
	for <linux-sparse@vger.kernel.org>; Mon,  9 Nov 2026 20:33:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87CA9606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=eVSYsiJM
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jNhM36bkyz1XMYJK;
	Mon,  9 Nov 2026 20:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1794256414; x=1796848415; bh=MEJWS
	Y/WIrHmOt8+p9vSlvw+Vct9t3m6H9LLvn5TkqU=; b=eVSYsiJMcx1SVw43BV7Ln
	hrWUoaqP6ehkmUJAMrBLSg1ueCaoZVhbg3U4nUhT2hmmBQxw/L+tA9gLjV5gXrc0
	bEqGaZUpnyNa8Tz3O4vV+xTh9+IFpWcOMKP92PRb+lMvGdGeUjDr17qjj2ufmvld
	ffWlhuU7uvT9oc+ubuR34vZndNEOmITQ6203VgXp6LWOIJRkv9UM5DTtoNum5LOo
	ot5vYZdT10wI2Ux6YrcdAYfkwjpMCaNcev6MXtKZ6wKcsHCy0B6VvfoIy3L82Sih
	A/nD9G5piC1TEw7SYuWBtun1jqNOJDtagbk2Vr+RY7homBNaDZuHflt5h/WrPhLn
	A==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 6tIMKyqBZaP4; Mon,  9 Nov 2026 20:33:34 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jNhLx6T8gz1XM0nk;
	Mon,  9 Nov 2026 20:33:29 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 25/73] graph: Check PSEUDO_SYM before dereferencing insn->func->sym
Date: Mon,  9 Nov 2026 12:32:11 -0800
Message-ID: <20261109203259.362845-26-bvanassche@acm.org>
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

Verify that insn->func->type is PSEUDO_SYM before reading insn->func->sym
in graph_calls() so indirect calls through non-symbol pseudos do not read
mismatched union members.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 graph.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/graph.c b/graph.c
index be4cf282c0c7..e952b726fd30 100644
--- a/graph.c
+++ b/graph.c
@@ -135,28 +135,27 @@ static void graph_calls(struct entrypoint *ep, int =
internal)
 			if (!insn->bb)
 				continue;
 			if (insn->opcode =3D=3D OP_CALL &&
+			    insn->func->type =3D=3D PSEUDO_SYM &&
 			    internal =3D=3D !(insn->func->sym->ctype.modifiers & MOD_EXTERN))=
 {
=20
 				/* Find the symbol for the callee's definition */
 				struct symbol * sym;
-				if (insn->func->type =3D=3D PSEUDO_SYM) {
-					for (sym =3D insn->func->sym->ident->symbols;
-					     sym; sym =3D sym->next_id) {
-						if (sym->namespace & NS_SYMBOL && sym->ep)
-							break;
-					}
-
-					if (sym)
-						printf("bb%p -> bb%p"
-						       "[label=3D%d,line=3D%d,col=3D%d,op=3Dcall,style=3Dbold,weig=
ht=3D30];\n",
-						       bb, sym->ep->entry->bb,
-						       insn->pos.line, insn->pos.line, insn->pos.pos);
-					else
-						printf("bb%p -> \"%s\" "
-						       "[label=3D%d,line=3D%d,col=3D%d,op=3Dextern,style=3Ddashed]=
;\n",
-						       bb, show_pseudo(insn->func),
-						       insn->pos.line, insn->pos.line, insn->pos.pos);
+				for (sym =3D insn->func->sym->ident->symbols;
+				     sym; sym =3D sym->next_id) {
+					if (sym->namespace & NS_SYMBOL && sym->ep)
+						break;
 				}
+
+				if (sym)
+					printf("bb%p -> bb%p"
+					       "[label=3D%d,line=3D%d,col=3D%d,op=3Dcall,style=3Dbold,weigh=
t=3D30];\n",
+					       bb, sym->ep->entry->bb,
+					       insn->pos.line, insn->pos.line, insn->pos.pos);
+				else
+					printf("bb%p -> \"%s\" "
+					       "[label=3D%d,line=3D%d,col=3D%d,op=3Dextern,style=3Ddashed];=
\n",
+					       bb, show_pseudo(insn->func),
+					       insn->pos.line, insn->pos.line, insn->pos.pos);
 			}
 		} END_FOR_EACH_PTR(insn);
 	} END_FOR_EACH_PTR(bb);
