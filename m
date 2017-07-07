From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 31/34] ptrlist: explicitely tagged
Date: Fri,  7 Jul 2017 15:39:59 +0200
Message-ID: <20170707134002.49500-32-luc.vanoostenryck@gmail.com>
References: <20170707134002.49500-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:35852 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752823AbdGGNkt (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 7 Jul 2017 09:40:49 -0400
Received: by mail-lf0-f65.google.com with SMTP id f28so4001321lfi.3
        for <linux-sparse@vger.kernel.org>; Fri, 07 Jul 2017 06:40:48 -0700 (PDT)
In-Reply-To: <20170707134002.49500-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Linus Torvalds <torvalds@linux-foundation.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

---
 example.c | 20 ++++++++++----------
 ptrlist.h |  4 ++++
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/example.c b/example.c
index 691e0f97c..41ee712fe 100644
--- a/example.c
+++ b/example.c
@@ -394,7 +394,7 @@ static void flush_reg(struct bb_state *state, struct hardreg *reg)
 		return;
 	reg->dead = 0;
 	reg->used = 1;
-	FOR_EACH_PTR(reg->contains, pseudo) {
+	FOR_EACH_TAGGED_PTR(reg->contains, pseudo) {
 		if (CURRENT_TAG(pseudo) & TAG_DEAD)
 			continue;
 		if (!(CURRENT_TAG(pseudo) & TAG_DIRTY))
@@ -447,7 +447,7 @@ static void mark_reg_dead(struct bb_state *state, pseudo_t pseudo, struct hardre
 {
 	pseudo_t p;
 
-	FOR_EACH_PTR(reg->contains, p) {
+	FOR_EACH_TAGGED_PTR(reg->contains, p) {
 		if (p != pseudo)
 			continue;
 		if (CURRENT_TAG(p) & TAG_DEAD)
@@ -532,7 +532,7 @@ static struct hardreg *find_in_reg(struct bb_state *state, pseudo_t pseudo)
 		pseudo_t p;
 
 		reg = hardregs + i;
-		FOR_EACH_PTR(reg->contains, p) {
+		FOR_EACH_TAGGED_PTR(reg->contains, p) {
 			if (p == pseudo) {
 				last_reg = i;
 				output_comment(state, "found pseudo %s in reg %s (busy=%d)", show_pseudo(pseudo), reg->name, reg->busy);
@@ -872,7 +872,7 @@ static void kill_dead_reg(struct hardreg *reg)
 	if (reg->dead) {
 		pseudo_t p;
 		
-		FOR_EACH_PTR(reg->contains, p) {
+		FOR_EACH_TAGGED_PTR(reg->contains, p) {
 			if (CURRENT_TAG(p) & TAG_DEAD) {
 				DELETE_CURRENT_PTR(p);
 				reg->dead--;
@@ -912,7 +912,7 @@ static void generate_binop(struct bb_state *state, struct instruction *insn)
 static int is_dead_reg(struct bb_state *state, pseudo_t pseudo, struct hardreg *reg)
 {
 	pseudo_t p;
-	FOR_EACH_PTR(reg->contains, p) {
+	FOR_EACH_TAGGED_PTR(reg->contains, p) {
 		if (p == pseudo)
 			return CURRENT_TAG(p) & TAG_DEAD;
 	} END_FOR_EACH_PTR(p);
@@ -1007,7 +1007,7 @@ static void kill_pseudo(struct bb_state *state, pseudo_t pseudo)
 		pseudo_t p;
 
 		reg = hardregs + i;
-		FOR_EACH_PTR(reg->contains, p) {
+		FOR_EACH_TAGGED_PTR(reg->contains, p) {
 			if (p != pseudo)
 				continue;
 			if (CURRENT_TAG(p) & TAG_DEAD)
@@ -1544,7 +1544,7 @@ static void fill_output(struct bb_state *state, pseudo_t pseudo, struct storage
 		struct hardreg *reg = hardregs + i;
 		pseudo_t p;
 
-		FOR_EACH_PTR(reg->contains, p) {
+		FOR_EACH_TAGGED_PTR(reg->contains, p) {
 			if (p == pseudo) {
 				write_reg_to_storage(state, reg, pseudo, out);
 				return;
@@ -1652,7 +1652,7 @@ static void generate_output_storage(struct bb_state *state)
 			int flushme = 0;
 
 			reg->busy = REG_FIXED;
-			FOR_EACH_PTR(reg->contains, p) {
+			FOR_EACH_TAGGED_PTR(reg->contains, p) {
 				if (p == entry->pseudo) {
 					flushme = -100;
 					continue;
@@ -1949,9 +1949,9 @@ int main(int argc, char **argv)
 
 	compile(sparse_initialize(argc, argv, &filelist));
 	dbg_dead = 1;
-	FOR_EACH_PTR_NOTAG(filelist, file) {
+	FOR_EACH_PTR(filelist, file) {
 		compile(sparse(file));
-	} END_FOR_EACH_PTR_NOTAG(file);
+	} END_FOR_EACH_PTR(file);
 	return 0;
 }
 
diff --git a/ptrlist.h b/ptrlist.h
index 9e16adb36..1a0d7225c 100644
--- a/ptrlist.h
+++ b/ptrlist.h
@@ -190,6 +190,10 @@ do {										\
 #define FOR_EACH_PTR(head, ptr) \
 	DO_FOR_EACH(head, ptr, __cur##ptr, CUR_ENTRY)
 
+#define FOR_EACH_TAGGED_PTR(head, ptr) \
+	FOR_EACH_PTR(head, ptr) \
+	ptr = __PTR_STRIP_TAG(ptr);
+
 #define END_FOR_EACH_PTR(ptr) \
 	DO_END_FOR_EACH(ptr, __cur##ptr)
 
-- 
2.13.0

