Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792432617;
	b=N6NSubvnqQHEG1Wm5HWLORzlQow9rKCw7okeOnZt8vR3c1TpgmLCPhOHDm6FwTfuDxUj
	 g5Fv4JL6erDxmYhHvhSJoXS69PZi1EBHtjzzuQT4GDG/x4BXz8OHCNsTWwQShc1wd63ht
	 ZKpzxFdl2tPUopZzTRBCKJAkUHy6kT1UVFtAczQ3vFOSBMOeWpSmGikillogOv0vC5rig
	 w/5asefbi9IZRu5QCQFB6HEJF33N52G5wCBlK/iHVbiHymvDG1ZBSyGe/jPwyjSz7Khpo
	 nxiMow5dblR9OiekIlqUpYNcNpcZItm6YNAlOXaFvw1g/2CUMwIGSWY6tumQJx9J4fQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792432617;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=HYQWmZllDuRCgFKi0kDJF8fwFNXIgQAStj4Vi2xbENY=;
	b=fzBE4rlsreAiJHkCQakWIwszLaa20PQeQJKOMaA4JPkiVgbBx+GUbfPILWj5vZ3LHWCA
	 wb7gyEg01hfI63iy+m/gduOjE8xO/nJpUmmwgOYLWC8Onu9tmwm2b4LfLFFGo/l4AtRJ+
	 uk1yjgeTxITA6Md9+o+07Oe34NcXAlv4YhWr8jcDMmroRgzLkx5N99pBkfHJDVu4AtKPT
	 lTq34+oWPzVtccU5eiPMWHpEhit/rfUNv5hEC0MFoVPZO++ZPQivACZgE7WoQBsyyZfAG
	 kO3jYsIC7xEwk+abB92gAvsfVXsoXMmsCG3C/SpObUvX0anSWuUXAwfdBnLVjtOpEjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=2lJp3JiS;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC72606A31D
	for <linux-sparse@vger.kernel.org>; Mon, 19 Oct 2026 17:56:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BCC72606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=2lJp3JiS
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4j7jsr4pGwz1XM30g;
	Mon, 19 Oct 2026 17:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1792432606; x=1795024607; bh=HYQWm
	ZllDuRCgFKi0kDJF8fwFNXIgQAStj4Vi2xbENY=; b=2lJp3JiS1npiyjBr7RHuo
	aLDw7uWvWbnoafjUtG73T1Z7Vl1qOmRFE5wToTw89YsPwZFQrRpvpGQz9HL8BG3z
	j/l7G8g42yqMTkUJYHxQP1csUTpEcfXHNaQZmaRktClAsruo38HOmZy5PXmHu2HQ
	k1rzdMS4GyFZp9hu0+kwyu4qNez3tKu4WaUUU3mwdkUO11R7FHeJujqYzN3bX8nQ
	Zqpyr69XHOScioGaHHSb39ytD+woM/cgv5MpfSYqXn/3jZtfdT788Qn7SWVwWqYT
	FT1P+hES94/hI5Yv3R2yQP6x+Q7YovOSif57SI+GufWX1vKRC2uWqqApwKT4f68B
	Q==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id VX6yswr3zFQ9; Mon, 19 Oct 2026 17:56:46 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (245.199.118.34.bc.googleusercontent.com [34.118.199.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4j7jsp0l2Yz1XM30r;
	Mon, 19 Oct 2026 17:56:46 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: linux-sparse@vger.kernel.org
Cc: Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 17/20] llvm: Free leaked allocations and LLVM objects
Date: Mon, 19 Oct 2026 10:56:30 -0700
Message-ID: <20261019175633.415493-18-bvanassche@acm.org>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
In-Reply-To: <20261019175633.415493-1-bvanassche@acm.org>
References: <20261019175633.415493-1-bvanassche@acm.org>
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

Include <stdlib.h> in sparse-llvm.c, free arg_type after calling
LLVMFunctionType() in sym_func_type(), free args after emitting the call
instruction in output_op_call(), call LLVMDisposeBuilder() at the end of
output_fn(), and jump to a cleanup label when die_if_error is set in
main() so LLVMDisposeModule() executes before returning.

Prevent memory leaks of temporary argument arrays, per-function LLVM IR
builders, and the LLVM module during both normal compilation and error
exits under LeakSanitizer.

Fixes: 45a6fbff8250 ("sparse, llvm: Initial commit")
Fixes: 404705a0c86d ("sparse, llvm: implement OP_CALL")
Fixes: 064c4adfb5fd ("sparse, llvm: Function pointer code generation")
Fixes: 469e5d6ea335 ("sparse, llvm: die if error")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 sparse-llvm.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index 1155c2341251..70e0ff6f58a4 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -10,6 +10,7 @@
=20
 #include <stdbool.h>
 #include <stdio.h>
+#include <stdlib.h>
 #include <unistd.h>
 #include <string.h>
 #include <assert.h>
@@ -53,6 +54,7 @@ static LLVMTypeRef sym_func_type(struct symbol *sym)
 	int n_arg =3D symbol_list_size(sym->arguments);
 	LLVMTypeRef *arg_type =3D calloc(n_arg, sizeof(LLVMTypeRef));
 	LLVMTypeRef ret_type =3D func_return_type(sym);
+	LLVMTypeRef fn_type;
 	struct symbol *arg;
 	int idx =3D 0;
=20
@@ -62,7 +64,9 @@ static LLVMTypeRef sym_func_type(struct symbol *sym)
 		arg_type[idx++] =3D symbol_type(arg_sym);
 	} END_FOR_EACH_PTR(arg);
=20
-	return LLVMFunctionType(ret_type, arg_type, n_arg, sym->variadic);
+	fn_type =3D LLVMFunctionType(ret_type, arg_type, n_arg, sym->variadic);
+	free(arg_type);
+	return fn_type;
 }
=20
 static LLVMTypeRef sym_array_type(struct symbol *sym)
@@ -858,6 +862,7 @@ static void output_op_call(struct function *fn, struc=
t instruction *insn)
 	(void) fntype;
 	target =3D LLVMBuildCall(fn->builder, func, args, n_arg, name);
 #endif
+	free(args);
=20
 	insn->target->priv =3D target;
 }
@@ -1223,6 +1228,8 @@ static void output_fn(LLVMModuleRef module, struct =
entrypoint *ep)
 			} END_FOR_EACH_PTR(phi);
 		} END_FOR_EACH_PTR(insn);
 	} END_FOR_EACH_PTR(bb);
+
+	LLVMDisposeBuilder(function.builder);
 }
=20
 static LLVMValueRef output_data(LLVMModuleRef module, struct symbol *sym=
)
@@ -1372,6 +1379,7 @@ int main(int argc, char **argv)
 	struct string_list *filelist =3D NULL;
 	struct symbol_list *symlist;
 	LLVMModuleRef module;
+	int ret =3D 0;
 	char *file;
=20
 	symlist =3D sparse_initialize(argc, argv, &filelist);
@@ -1383,8 +1391,10 @@ int main(int argc, char **argv)
=20
 	FOR_EACH_PTR(filelist, file) {
 		symlist =3D sparse(file);
-		if (die_if_error)
-			return 1;
+		if (die_if_error) {
+			ret =3D 1;
+			goto out;
+		}
 		compile(module, symlist);
 	} END_FOR_EACH_PTR(file);
=20
@@ -1392,8 +1402,9 @@ int main(int argc, char **argv)
=20
 	LLVMWriteBitcodeToFD(module, STDOUT_FILENO, 0, 0);
=20
+out:
 	LLVMDisposeModule(module);
=20
 	report_stats();
-	return 0;
+	return ret;
 }
