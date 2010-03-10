From: Christopher Li <sparse@chrisli.org>
Subject: Re: Sparse crash when mixing int and enum in ternary operator
Date: Wed, 10 Mar 2010 13:56:15 -0800
Message-ID: <70318cbf1003101356u48688264na5c9d71bc1ef4300@mail.gmail.com>
References: <1268097872.16227.10.camel@mj>
	 <201003100030.50165.kdudka@redhat.com> <1268183362.2615.17.camel@mj>
	 <201003101705.36304.kdudka@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pz0-f194.google.com ([209.85.222.194]:60708 "EHLO
	mail-pz0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932769Ab0CJV4Q convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 10 Mar 2010 16:56:16 -0500
Received: by pzk32 with SMTP id 32so313926pzk.4
        for <linux-sparse@vger.kernel.org>; Wed, 10 Mar 2010 13:56:15 -0800 (PST)
In-Reply-To: <201003101705.36304.kdudka@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Kamil Dudka <kdudka@redhat.com>
Cc: Pavel Roskin <proski@gnu.org>, Josh Triplett <josh@joshtriplett.org>, linux-sparse@vger.kernel.org

On Wed, Mar 10, 2010 at 8:05 AM, Kamil Dudka <kdudka@redhat.com> wrote:
> On Wed March 10 2010 02:09:22 Pavel Roskin wrote:
>> I wonder is the quirk handling could be skipped for EXPR_SELECT, but=
 I'm
>> fine with it if it's harmless.
>
> That's more likely question for sparse developers. =A0I have no test-=
case which
> goes through the EXPR_SELECT path, so that I can't test it actually.

Hi, Sorry for the late reply. I did play with your patch yesterday.
I believe this is the code we are talking about:

+warn_for_enum_conversions(struct expression *expr, struct symbol *type=
)
+{
+	switch (expr->type) {
+	case EXPR_CONDITIONAL:
+	case EXPR_SELECT:
+		do_warn_for_enum_conversions(expr->cond_true
+					     /* handle the "?:" quirk */
+					     ?: expr->conditional,
+					     type);
+		do_warn_for_enum_conversions(expr->cond_false, type);
+		break;
+
+	default:
+		do_warn_for_enum_conversions(expr, type);
+	}
+}
+

I feel that we shouldn't do special handling for EXPR_CONDITIONAL here.
We should just make the warn_for_enum_conversions more robust.
Special handing EXPR_CONDITIONAL here is just an one off thing.
What if there is a nested EXPR_CONDITIONAL inside the expr->cond_true?
See, your do_warn_for_enum_conversions() still need to handle
EXPR_CONDITIONAL any way. So I argue that we don't need that
special case for EXPR_CONDITIONAL here.

BTW, EXPR_SELECT only appear after expand stage. So you should not
see EXPR_SELECT in the evaluate stage.

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
