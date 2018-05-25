import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class CustomListTitle extends StatelessWidget{

  const CustomListTitle({Key key,this.leading, this.title, this.subtitle, this.trailing,
      this.isThreeLine, this.dense, this.enabled, this.onTap, this.onLongPress,
      this.selected}):
        assert(isThreeLine != null),
        assert(enabled != null),
        assert(selected != null),
        assert(!isThreeLine || subtitle != null),
        super(key: key);

  final Widget leading;

  final Widget title;

  final Widget subtitle;

  final Widget trailing;

  final bool isThreeLine;

  final bool dense;

  final bool enabled;

  final GestureTapCallback onTap;

  final GestureLongPressCallback onLongPress;

  final bool selected;

  static Iterable<Widget> divideTiles({BuildContext context,@required Iterable<Widget> tiles,Color color})  sync*{
    assert(tiles !=null);
    assert(color !=null || context !=null);
    final Iterator<Widget> iterator = tiles.iterator;
    final bool isNotEmpty = iterator.moveNext();

    final Decoration decoration = new BoxDecoration(
      border: new Border(
        bottom: Divider.createBorderSide(context,color: color),
      ),
    );

    Widget tile = iterator.current;
    while(iterator.moveNext()){
      yield new DecoratedBox(
          position: DecorationPosition.foreground,
          decoration: decoration,
          child: tile,
      );
      tile = iterator.current;
    }
    if(isNotEmpty)
      yield tile;
  }

  Color _iconColor(ThemeData theme,ListTileTheme tileTheme){
    if(!enabled)
      return theme.disabledColor;
    if(selected && tileTheme?.selectedColor != null){
      return tileTheme.selectedColor;
    }

    if(!selected && tileTheme?.iconColor != null){
      return tileTheme.iconColor;
    }

    switch(theme.brightness){
      case Brightness.light:
        return selected?theme.primaryColor:Colors.black45;
      case Brightness.dark:
        return selected ? theme.accentColor : null;

    }
    assert(theme.brightness !=null);
    return null;
  }

  Color _textColor(ThemeData theme,ListTileTheme tileTheme,Color defaultColor){
    if(!enabled){
      return theme.disabledColor;
    }

    if(selected && tileTheme?.selectedColor != null){
      return tileTheme.selectedColor;
    }

    if(!selected && tileTheme?.textColor != null){
      return tileTheme.textColor;
    }

    if(selected){
      switch(theme.brightness){
        case Brightness.light:
          return theme.primaryColor;
        case Brightness.dark:
          return theme.accentColor;
      }
    }
    return defaultColor;
  }


  bool _denseLayout(ListTileTheme tileTheme){
    return dense != null ? dense:(tileTheme?.dense??false);
  }

  TextStyle _titleTextStyle(ThemeData data,ListTileTheme tileTheme){
    TextStyle style;
    if(tileTheme != null){
      switch(tileTheme.style){
        case ListTileStyle.drawer:
          style = data.textTheme.body2;
          break;
        case ListTileStyle.list:
          style = data.textTheme.subhead;
          break;
      }
    }else{
      style = data.textTheme.subhead;
    }
    final Color color = _textColor(data, tileTheme, style.color);
    return style.copyWith(fontSize: 14.0,color: color);
  }


  TextStyle _subtitleTextStyle(ThemeData theme,ListTileTheme tileTheme){
    final TextStyle style = theme.textTheme.body1;
    final Color color = _textColor(theme, tileTheme, theme.textTheme.caption.color);
    return style.copyWith(color: color,fontSize: 12.0);
  }


  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));
    final ThemeData theme = Theme.of(context);
    final ListTileTheme tileTheme = ListTileTheme.of(context);

    final bool isTwoLine = !isThreeLine && subtitle != null;
    final bool isOneLine = !isThreeLine && !isTwoLine;
    double tileHeight;
    if (isOneLine) {
      tileHeight = 50.0;
    } else if (isTwoLine)
      tileHeight = _denseLayout(tileTheme)?60.0:72.0;
    else
      tileHeight  = _denseLayout(tileTheme)?76.0:88.0;


    final List<Widget> children = <Widget>[];

    IconThemeData iconThemeData;
    if(leading != null || trailing != null){
        iconThemeData = new IconThemeData(color: _iconColor(theme, tileTheme));
    }
    if(leading != null){
       children.add(IconTheme.merge(
           data: iconThemeData,
           child: new Container(
             margin: const EdgeInsetsDirectional.only(end: 16.0),
             width: 30.0,
             alignment: AlignmentDirectional.centerStart,
             child: leading,
           ),
       )
       );
    }


    final Widget primaryLine = new AnimatedDefaultTextStyle(
        child: title??new Container(),
        style: _titleTextStyle(theme, tileTheme),
        duration: kThemeChangeDuration
    );
    Widget center = primaryLine;

    if(subtitle !=null && (isTwoLine || isThreeLine)){
      center =new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          primaryLine,
          new AnimatedDefaultTextStyle(
              child: subtitle,
              style: _subtitleTextStyle(theme, tileTheme),
              duration: kThemeChangeDuration),
        ],
      );
    }

    children.add(new Expanded(
        child: center),
    );

    if(trailing != null){
      children.add(IconTheme.merge(
          data: iconThemeData,
          child: new Container(
              margin: const EdgeInsetsDirectional.only(start: 16.0),
            alignment: AlignmentDirectional.centerEnd,
            child: trailing,
          ),),
      );
    }
    
    
    return new InkWell(
      highlightColor: Colors.grey.withAlpha(10),
      splashColor: Colors.transparent,
      onTap: enabled?onTap:null,
      onLongPress: enabled?onLongPress:null,
      child: new Semantics(
        selected: selected,
        enabled: enabled,
        child: new ConstrainedBox(
            constraints: new BoxConstraints(maxHeight: tileHeight),
            child: new Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0.0),
                child: new UnconstrainedBox(
                    constrainedAxis: Axis.horizontal,
                    child: new SafeArea(
                        top: false,
                        bottom: false,
                        child: new Row(children: children),
                    ),
                ),
            ),

        ),
      ),
    );

  }


}


class CustomCheckboxListTile extends StatelessWidget{


  final bool value;

  final ValueChanged<bool> onChanged;

  final Color activeColor;

  final Widget title;

  final Widget subtitle;

  final Widget secondary;

  final bool isThreeLine;

  final bool dense;

  final bool selected;


  CustomCheckboxListTile({Key key,
    @required this.value,
    @required this.onChanged,
    this.activeColor,
    this.title,
    this.subtitle,
    this.secondary,
    this.isThreeLine:false,
    this.dense,
    this.selected:false}):assert (value !=null),
          assert(isThreeLine != null),
          assert(!isThreeLine || subtitle !=null),
          assert(selected != null),
          super(key:key);

  @override
  Widget build(BuildContext context) {
    final Widget leading = new Container(
      width: 18.0,
      child: new Checkbox(
          value: value,
          onChanged: onChanged,
          activeColor: activeColor,
      ),
    );

    Widget trailing = secondary;
    return new MergeSemantics(
      child: ListTileTheme.merge(
          selectedColor: activeColor?? Theme.of(context).accentColor,
          child: new CustomListTitle(
            leading:leading,
            title: title,
            subtitle: subtitle,
            trailing: trailing,
            isThreeLine: isThreeLine,
            dense: dense,
            enabled: onChanged != null,
            onTap: onChanged != null ? (){
              onChanged(!value);
            }:null,
            selected: selected,
          )),
    );
  }
}