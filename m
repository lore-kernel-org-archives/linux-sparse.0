From: Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH] show_parse: avoid null pointer dereference in do_show_type()
Date: Thu, 16 Jan 2020 18:48:38 +0100
Message-ID: <20200116174838.GA32100@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34931 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2394372AbgAPRsu (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 16 Jan 2020 12:48:50 -0500
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Alexey Gladkov <gladkov.alexey@gmail.com>, linux-sparse@vger.kernel.org

do_show_type() checks sym->type inside the "if (!sym || ...)" block.

While at it, remove the trailing whitespaces.

Fixes: 0fe7ebb9 ("show-parse: do not display base type's redundant specifie=
rs")
Reported-by: Alexey Gladkov <gladkov.alexey@gmail.com>
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 show-parse.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/show-parse.c b/show-parse.c
index f0ea9ca..044465e 100644
--- a/show-parse.c
+++ b/show-parse.c
@@ -300,12 +300,12 @@ deeper:
 =09=09if (as)
 =09=09=09prepend(name, "%s ", show_as(as));
=20
-=09=09if (sym->type =3D=3D SYM_BASETYPE || sym->type =3D=3D SYM_ENUM)
+=09=09if (sym && (sym->type =3D=3D SYM_BASETYPE || sym->type =3D=3D SYM_EN=
UM))
 =09=09=09mod &=3D ~MOD_SPECIFIER;
 =09=09s =3D modifier_string(mod);
 =09=09len =3D strlen(s);
-=09=09name->start -=3D len;   =20
-=09=09memcpy(name->start, s, len); =20
+=09=09name->start -=3D len;
+=09=09memcpy(name->start, s, len);
 =09=09mod =3D 0;
 =09=09as =3D NULL;
 =09}
--=20
2.5.0
